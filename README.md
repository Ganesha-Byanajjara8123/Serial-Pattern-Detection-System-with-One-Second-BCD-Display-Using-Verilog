# Happy_BDAY_Design_problem

1)Waveform for ready & hit:

<img width="940" height="476" alt="image" src="https://github.com/user-attachments/assets/773f645e-8cf9-42cf-a713-d8dee0c4b44c" />




2)Waveform for second count[13:0] & 1-second pulse for every second and 0-9999(10,000 clk cycles):
i)And every 0-9999(270f in decimal) one_sec_pulse is enabled.

<img width="940" height="469" alt="image" src="https://github.com/user-attachments/assets/d20a523d-bd12-4341-951f-0896ab0e5955" />



3)wavefrom about binary to  BCD convert  & BCD to 7-segment.
Here hits are counted within one second and latched at the one-second pulse. The latched count is correctly converted to BCD and 7-segment outputs, confirming proper timing and display functionality.
(I take wavefrom after one_sec_pulse become low, because we get stable outputs after every 1-second.)


<img width="975" height="483" alt="image" src="https://github.com/user-attachments/assets/be9cfff5-9e55-438a-bcda-e084713e2d15" />





#**Block-Diagram:**  Transmitter–Receiver Based Pattern Detection System(Happy BDAY design problem)



<img width="507" height="1082" alt="Happy_BDAY_Github drawio" src="https://github.com/user-attachments/assets/6ca25c0d-1185-421b-9e44-c2d248805721" />





**Explination of the above block diagram**: The system operates on a common 10 kHz clock. On the transmitter(TX_COUNTER) side, a 10-bit counter(0-9) generates data which is converted into a serial stream using a parallel-to-serial converter(Serial_trannsmitter). The converter sends one bit per clock and generates a ready pulse after every 10 bits, ensuring controlled data transfer.
The serial stream is continuously monitored by the receiver using a 9-bit shift register(shift_reg[8:0]). When the contents match the predefined birthday pattern(110010100=12/20-my BDAY), a hit pulse is generated.
 a 1-second timer derived from the same clock counts 10,000 cycles and generates a one-second pulse. All hit pulses occurring within this interval are accumulated, latched, and reset every second.The latched value(hit_count_latched[9:0]) is then converted from binary to BCD(bcd_h,bcd_t,bcd_o) and encoded to a 7-segment display(seg_hundreds,tens,ones), ensuring the display updates once per second.




