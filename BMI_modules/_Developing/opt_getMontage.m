function MNT = opt_getMontage(SMT)

clab= {'Fpz', ...
       'Fp1','AFp1','AFp2','Fp2', ...
       'AF7','AF5','AF3','AFz','AF4','AF6','AF8', ...
       'FAF5','FAF1','FAF2','FAF6', ...
       'F9','F7','F5','F3','F1','Fz','F2','F4','F6','F8','F10', ...
       'FFC9','FFC7','FFC5','FFC3','FFC1','FFC2','FFC4','FFC6','FFC8','FFC10', ...
       'FT9','FT7','FC5','FC3','FC1','FCz','FC2','FC4','FC6','FT8','FT10', ...
       'CFC9','CFC7','CFC5','CFC3','CFC1','CFC2','CFC4','CFC6','CFC8','CFC10', ...
       'T9','T7','C5','C3','C1','Cz','C2','C4','C6','T8','T10', ...
       'A1','CCP7','CCP5','CCP3','CCP1','CCP2','CCP4','CCP6','CCP8','A2', ...
       'TP9','TP7','CP5','CP3','CP1','CPz','CP2','CP4','CP6','TP8','TP10', ...
       'PCP9','PCP7','PCP5','PCP3','PCP1','PCP2','PCP4','PCP6','PCP8','PCP10', ...
       'P9','P7','P5','P3','P1','Pz','P2','P4','P6','P8','P10', ...
       'PPO7','PPO5','PPO3','PPO1','PPO2','PPO4','PPO6','PPO8',  ...
       'PO9','PO7','PO5','PO3','PO1','POz','PO2','PO4','PO6','PO8','PO10', ...
       'OPO1','OPO2', ...
       'O9','O1','O2','O10', ...
       'Oz', ...
       'OI1','OI2', ...
       'I1','Iz','I2'};

a= 90/4;
b= 90/4;

ea= a * [ 0 ...
          -4 -1.5 1.5 4 ...
          -4 -3 -2 0 2 3 4 ...
          -2.5 -0.65 0.65 2.5 ...
          -5 -4 -3 -2 -1 0 1 2 3 4 5 ...
          -4.5 -3.5 -2.5 -1.5 -0.5 0.5 1.5 2.5 3.5 4.5 ...
          -5 -4 -3 -2 -1 0 1 2 3 4 5 ...
          -4.5 -3.5 -2.5 -1.5 -0.5 0.5 1.5 2.5 3.5 4.5 ...
          -5 -4 -3 -2 -1 0 1 2 3 4 5 ...
          -5 -3.5 -2.5 -1.5 -0.5 0.5 1.5 2.5 3.5 5 ...
          -5 -4 -3 -2 -1 0 1 2 3 4 5 ...
          -4.5 -3.5 -2.5 -1.5 -0.5 0.5 1.5 2.5 3.5 4.5 ...
          -5 -4 -3 -2 -1 0 1 2 3 4 5 ...
          -4.5 -3 -2 -0.65 0.65 2 3 4.5 ...
          -5.5 -4 -3 -2 -1 0 1 2 3 4 5.5 ...
          -1.5 1.5 ...
          -6.5 -4 4 6.5 ...
          0 ...
          1.5 -1.5 ...
          1 0 -1];% direction of rotation reverses under the equator line!
              
eb= [   4*b ...
      3.5*b * ones(1,4) ...
        3*b * ones(1,7) ...
      2.5*b * ones(1,4) ...
        2*b * ones(1,11) ...
      1.5*b * ones(1,10) ...
        1*b * ones(1,11) ...
      0.5*b * ones(1,10) ...
        0*b * ones(1,11) ...
     -0.5*b * ones(1,10) ....
       -1*b * ones(1,11) ...
     -1.5*b * ones(1,10) ...
       -2*b * ones(1,11) ...
     -2.5*b * ones(1,8) ...
       -2.6*b, -3*b * ones(1,9), -2.6*b ...
     -3.5*b * ones(1,2) ...
     -3.5*b * ones(1,4) ...
       -4*b ...
     -4.5*b * ones(1,2) ...
       -5*b * ones(1,3)];
   
ea = ea*pi/180;
eb = eb*pi/180;
        
Position.x = 1 .* sin(ea) .* cos(eb);
Position.y = 1 .* sin(eb);
Position.z = 1 .* cos(ea) .* cos(eb);
Position.clab = clab;

alpha = asin(sqrt(Position.x.^2 + Position.y.^2));
stretch = 2-2*abs(alpha)/pi;
stretch(Position.z>0) = 2*abs(alpha(Position.z>0))/pi;
norm = sqrt(Position.x.^2 + Position.y.^2);
norm(norm == 0) = 1;

cx = Position.x.*stretch./norm;
cy = Position.y.*stretch./norm;

chan_idx = zeros(size(SMT.chan,2),1);

for i = 1:size(SMT.chan,2)
    chan_idx(i) = find(ismember(Position.clab, SMT.chan(i))); 
end

MNT.x = cx(chan_idx);
MNT.y = cy(chan_idx);

radius = 1.3;

MNT.x = MNT.x/radius;
MNT.y = MNT.y/radius;
MNT.chan = Position.clab;

end

