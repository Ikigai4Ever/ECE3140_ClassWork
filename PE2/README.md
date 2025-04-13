# PE2 - Ty Ahrens

This file is a partial product of the game breakout that has a movable paddle limited by boundaries, two rows of blocks that are generated and turned off if they match the fibonacci number currently displayed on the seven segment displays that are on the DE10-Lite development board. 

I had also recieved assistance from Blake Hudson and talked with Tyler and Evan about some of the process for the encoder.

# File Explainations

## Top_Entity 

This is the top entity for the entire workspace and does the computing of the fibonacci numbers as well as the timing for the incrementing and decrementing of the number dependent of if KEY0 is pressed or not. This also sends the digits of the fibonacci number to the bin2seg7_decoder which is takes a digit to be decoded into it's appropriate HEX output. 

In this main entity there is also a calculation of how to determine the direction of the rotary encoder and how to increment or decrement the paddle's position on the screen. THere is also a reset button (KEY1) that is used to put the paddle back on the middle of the screen incase it were to go offscreen. 

## seg7_decoder

This is a file that takes in a digit from the fibonacci number to output a binary vector that displays the appropriate number to each of the seven segment displays. 

## debouncer

This is a file that is used to debounce the signal for channel A and channel B of the rotary encoder to ensure that the signal being sent is recieved, especially when the rotary encoder is being spun fast. This takes in the signal directly from the rotary encoder and saves the last state and counts up a counter until the next clock cycle to match the timing of the clock and input of each channel.

## Image_Generator

This is the file that is responsible for all of the images that are displayed on the screen. This holds the dimensions of the paddle, the boarders, and each of the blocks along with their separation. Also, least significant two digits of the fibonacci number are sent to this file in order to turn of the corresponding block on the screen. 

