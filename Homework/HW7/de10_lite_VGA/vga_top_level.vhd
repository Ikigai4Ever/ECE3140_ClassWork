library ieee;
use ieee.std_logic_1164.all;

entity vga_top is
  generic (color : integer := 3);
  port (
    -- Inputs
    pixel_clk_m : IN STD_LOGIC;     
    reset_n_m   : IN STD_LOGIC;     
    key_m       : IN STD_LOGIC;

    -- Outputs
    h_sync_m : OUT STD_LOGIC;
    v_sync_m : OUT STD_LOGIC;
    red_m    : OUT STD_LOGIC_VECTOR(color DOWNTO 0);
    green_m  : OUT STD_LOGIC_VECTOR(color DOWNTO 0);
    blue_m   : OUT STD_LOGIC_VECTOR(color DOWNTO 0);

    -- SPI interface to ADXL345 accelerometer
    SPI_SDO : IN STD_LOGIC;
    SPI_SDI : OUT STD_LOGIC;
    SPI_CSN : OUT STD_LOGIC;
    SPI_CLK : OUT STD_LOGIC
  );
end vga_top;

architecture vga_structural of vga_top is

  -- COMPONENT DECLARATIONS
  component vga_pll_25_175
    port (
      inclk0 : IN STD_LOGIC := '0';
      c0     : OUT STD_LOGIC
    );
  end component;

  component vga_controller
    port (
      pixel_clk : IN STD_LOGIC;
      reset_n   : IN STD_LOGIC;
      h_sync    : OUT STD_LOGIC;
      v_sync    : OUT STD_LOGIC;
      disp_ena  : OUT STD_LOGIC;
      column    : OUT INTEGER;
      row       : OUT INTEGER;
      n_blank   : OUT STD_LOGIC;
      n_sync    : OUT STD_LOGIC
    );
  end component;

  component hw_image_generator
    port (
      max10_clk         : IN STD_LOGIC;
      disp_ena          : IN STD_LOGIC;
      row               : IN INTEGER;
      column            : IN INTEGER;
      KEY               : IN STD_LOGIC;
      red               : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      green             : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      blue              : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      shift_red_left    : IN STD_LOGIC;
      shift_red_right   : IN STD_LOGIC;
      shift_green_left  : IN STD_LOGIC;
      shift_green_right : IN STD_LOGIC
    );
  end component;

  component hw7p3
    port (
      clk               : IN STD_LOGIC;
      accel_x           : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      accel_y           : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      KEY               : IN STD_LOGIC;
      shift_red_left    : OUT STD_LOGIC;
      shift_red_right   : OUT STD_LOGIC;
      shift_green_left  : OUT STD_LOGIC;
      shift_green_right : OUT STD_LOGIC
    );
  end component;

  component accelerometer
    port (
      reset_n     : IN STD_LOGIC;
      clk         : IN STD_LOGIC;
      data_valid  : OUT STD_LOGIC;
      data_x      : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      data_y      : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      data_z      : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      SPI_SDI     : OUT STD_LOGIC;
      SPI_SDO     : IN STD_LOGIC;
      SPI_CSN     : OUT STD_LOGIC;
      SPI_CLK     : OUT STD_LOGIC
    );
  end component;

  -- SIGNALS
  signal pll_clk         : STD_LOGIC;
  signal dispEn          : STD_LOGIC;
  signal rowSignal       : INTEGER;
  signal colSignal       : INTEGER;

  signal red_s, green_s, blue_s : STD_LOGIC_VECTOR(3 downto 0);

  signal accel_x_s, accel_y_s : STD_LOGIC_VECTOR(15 downto 0);

  signal shift_red_left_s, shift_red_right_s : STD_LOGIC;
  signal shift_green_left_s, shift_green_right_s : STD_LOGIC;

begin

  -- PLL for VGA timing (25.175 MHz)
  U1 : vga_pll_25_175
    port map (
      inclk0 => pixel_clk_m,
      c0     => pll_clk
    );

  -- VGA timing controller
  U2 : vga_controller
    port map (
      pixel_clk => pll_clk,
      reset_n   => reset_n_m,
      h_sync    => h_sync_m,
      v_sync    => v_sync_m,
      disp_ena  => dispEn,
      column    => colSignal,
      row       => rowSignal,
      n_blank   => open,
      n_sync    => open
    );

  -- Accelerometer interface
  U3 : accelerometer
    port map (
      reset_n    => reset_n_m,
      clk        => pixel_clk_m,
      data_valid => open,
      data_x     => accel_x_s,
      data_y     => accel_y_s,
      data_z     => open,
      SPI_SDI    => SPI_SDI,
      SPI_SDO    => SPI_SDO,
      SPI_CSN    => SPI_CSN,
      SPI_CLK    => SPI_CLK
    );

  -- Tilt processor (hw7p3)
  U4 : hw7p3
    port map (
      clk               => pixel_clk_m,
      accel_x           => accel_x_s,
      accel_y           => accel_y_s,
      KEY               => key_m,
      shift_red_left    => shift_red_left_s,
      shift_red_right   => shift_red_right_s,
      shift_green_left  => shift_green_left_s,
      shift_green_right => shift_green_right_s
    );

  -- Image Generator (hw7p2)
  U5 : hw_image_generator
    port map (
      max10_clk         => pixel_clk_m,
      disp_ena          => dispEn,
      row               => rowSignal,
      column            => colSignal,
      KEY               => key_m,
      red               => red_s,
      green             => green_s,
      blue              => blue_s,
      shift_red_left    => shift_red_left_s,
      shift_red_right   => shift_red_right_s,
      shift_green_left  => shift_green_left_s,
      shift_green_right => shift_green_right_s
    );

  -- Assign colors to output
  red_m   <= red_s(color downto 0);
  green_m <= green_s(color downto 0);
  blue_m  <= blue_s(color downto 0);

end vga_structural;
