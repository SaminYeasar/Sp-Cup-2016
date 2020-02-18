# Sp-Cup-2016

Details available at Sigport: https://sigport.org/documents/enf-based-grid-classification-system-identifying-region-origin-digital-recordings-team

Using "Machine Learning" & additional "novel proposed feature" we proved an drastic accuracy in identifying grid around the world using ENF signal. My team "Fourier's Underlings" stood 11th in "IEEE SP Cup 2016" . We had bad accuracy in the competition due to inefficient ENF extraction but later on we found published code [1] and used with available recording data online to test our proposed features efficiency and that happens to provide impressive result in classification accuracy

Abstract: The Electric Network Frequency (ENF) is the supply frequency of power distribution networks, which can be captured by multimedia signals recorded near electrical activities. It normally fluctuates slightly over time from its nominal value of 50 Hz/60 Hz. The ENF remain consistent across the entire power grid. This has led to the emergence of multiple forensic application like estimating the recording location and validating the time of recording. Recently an ENF based Machine Learning system was proposed which infers the region of recording from the power grids ENF signal extracted from the recorded multimedia signal, with the help of relevant features.
In this work, we report some features novel to this application which serve as identifying characteristics for detecting the region of origin of the multimedia recording. In addition to the ENF variation itself, the utilization of the ENF harmonics pattern extracted from the media signals as novel features enables a more accurate identification of the region of origin. These characteristics were used in a multiclass machine learning implementation to identify the grid of the recorded signal. We get Audio Efficiency 88.90% and Power 96.03% for our proposed features.

Online available data: 
[1] Adi Hajj-Ahmad, R., MinWu,. Spectrum Combining for ENF Signal Estimation - Dataset & Codes,. 2013 [cited 2017 March 03]; Available from: http://cwwongpatch2.no-ip.org/mast_new/research.php?t=enf.
