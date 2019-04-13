%% Modeling and Analysis of Single Layer Multi-band U-Slot Patch Antenna
%  Designed By- Hardik Srivastava & Adnan Qureshi
%  Simulated and Tested By- Arpit Verma & Chirag Shrivastava
% _frequency lower bound 3e9 and upper bound 6e9_
% _IEEE 802.11ac [2013] Standards_ @ Frequency 5Ghz
% _Fifth Generation WiFi_

%%
% _Define Parameters_ 
L = 26e-3;
W = 35.5e-3;
Uy1 = 19.5e-3;
Ux1 = 12e-3;
Ua1 = 2.1e-3;
Ud1 = 4.8e-3;
d = 13.5e-3;
h = 6e-3;
%%
% _Define radiator shape - Single U-slot_ 

s = antenna.Rectangle('Length',W,'Width',L,'NumPoints',40);
h1 = antenna.Rectangle('Length',Ua1,'Width',Uy1,'NumPoints',[2 20 2 20],'Center',[-Ux1/2 + Ua1/2, -L/2 + Ud1 + Uy1/2]);
h2 = antenna.Rectangle('Length',Ua1,'Width',Uy1,'NumPoints',[2 20 2 20],'Center',[Ux1/2 - Ua1/2, -L/2 + Ud1 + Uy1/2]);
h3 = antenna.Rectangle('Length',Ux1,'Width',Ua1,'NumPoints' ,[20 2 20 2],'Center',[0,-L/2 + Ud1 + Ua1/2]);
Uslot_patch = s-h1-h2-h3;
figure
show(Uslot_patch)
%%
% _Define ground shape_
Lgp = 71.88e-3;
Wgp = 52.6e-3;
p2  = antenna.Rectangle('Length',Lgp,'Width',Wgp);
%%
% _Define stack_

d1 = dielectric('FR4');
slotPatch = pcbStack;
slotPatch.Name = 'U-Slot Patch';
slotPatch.BoardThickness = h;
slotPatch.BoardShape = p2;
slotPatch.Layers = {Uslot_patch,d1,p2};
slotPatch.FeedLocations = [0 L/2-d 1 3];
slotPatch.FeedDiameter = 0.5e-3;
figure
show(slotPatch)

%%
% _Calculate and Plot Reflection Coefficient_
mesh(slotPatch,'MaxEdgeLength',.005)
%%
freq = linspace(3e9,6e9,51);
s1 = sparameters(slotPatch,freq);
s11Fig = figure;
rfplot(s1,1,1)
s11Ax = gca(s11Fig);
hold(s11Ax,'on');
%%
%_Calculate Impedance_ 
figure
impedance(slotPatch,3e9:1e9:6e9)
%%
% _Return Loss_
figure
returnLoss(slotPatch,3e9:1e9:6e9,72)
%%
% _Beamwidth_
figure
beamwidth(slotPatch,5e9,0,1:1:360)
%%
% _Pattern_
figure
pattern(slotPatch,5e9,'Type','efield','CoordinateSystem','polar')
%%
% _Directivity_
figure;
pattern(slotPatch,5e9,1:1:360,0);
%%
% _Calculate and plot VSWR of antenna_
figure;
vswr(slotPatch,3e9:1e9:6e9,72);
%% Calculate and plot pattern
% _Plot the radiation pattern for this antenna at the frequencies of best
% match in the band._
figure
pattern(slotPatch,5e9)
view(-45,30)
%%
% _Azimuth and Elevation 2.45 Ghz_
patternAzimuth(slotPatch,5e9);
figure;
patternElevation(slotPatch, 5e9);
%%
% _Near Field EH Field_ 
[X, Y, Z] = sphere(20);
Points = [X(:), Y(:), Z(:)].';
plot3(Points(1,:), Points(2,:), Points(3,:), 'x');
EHfields(slotPatch, 5e9, Points);
%%
% Current and charge distribution
figure;
charge(slotPatch,5e9);
figure;
current(slotPatch,5e9);

%% _Dual Band U Slot Antenna_

%%
% _Define Parameters Dual Band/Slot Antenna_
Ux1 = 12e-3;
Ux2 = 22e-3;
Uy1 = 19.5e-3;
Uy2 = 15e-3;
Ua2 = 2.1e-3;
Ud1 = 4.8e-3;
Ud2 = 1.5e-3;
%%
% _Define radiator shape - Dual Band U-slot_
h1 = antenna.Rectangle('Length',Ua1,'Width',Uy1,'NumPoints',[2 20 2 20],'Center',[-Ux1/2 + Ua1/2, -L/2 + Ud1 + Uy1/2]);
h2 = antenna.Rectangle('Length',Ua1,'Width',Uy1,'NumPoints',[2 20 2 20],'Center',[Ux1/2 - Ua1/2, -L/2 + Ud1 + Uy1/2]);
h3 = antenna.Rectangle('Length',Ux1,'Width',Ua1,'NumPoints' ,[20 2 20 2],'Center',[0,-L/2 + Ud1 + Ua1/2]);
Uslot_patch = s-h1-h2-h3;
h4 = antenna.Rectangle('Length',Ua2,'Width',Uy2,'NumPoints',[2 20 2 20],'Center',[-Ux2/2 + Ua2/2, -L/2 + Ud2 + Uy2/2]);
h5 = antenna.Rectangle('Length',Ua2,'Width',Uy2,'NumPoints',[2 20 2 20],'Center',[Ux2/2 - Ua2/2, -L/2 + Ud2 + Uy2/2]);
h6 = antenna.Rectangle('Length',Ux2,'Width',Ua2,'NumPoints' ,[20 2 20 2],'Center',[0,-L/2 + Ud2 + Ua2/2]);
DoubleUslot_patch = Uslot_patch-h4-h5-h6;
figure
show(DoubleUslot_patch)
%%
%
slotPatch.Layers = {DoubleUslot_patch,d1,p2};
figure;
show(slotPatch);
%%
figure;
mesh(slotPatch,'MaxEdgeLength',.005);
%%
% _RF Plot_
freq = linspace(3e9,6e9,51);
s2 = sparameters(slotPatch,freq);
figure(s11Fig)
rfplot(s2,1,1);
%%
figure;
beamwidth(DoubleUslot_patch,5e9,0,1:1:360);