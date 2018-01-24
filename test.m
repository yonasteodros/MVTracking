clc;clear all;close all
theta1=[1 10 15 16 -360 -350 -340 20 40 30 35 25 55 65 355 60 90];
theta2=[-90 -60 -65 -70 -75 -80 180 -185 190 -95 -100 -91 -85 -68 -55 -89 -83];
theta=[theta1, theta2];
alpha_rad = circ_ang2rad(theta)
circ_plot(alpha_rad,'pretty','bo',true,'linewidth',2,'color','r'),
[cid, alpha, mu] =circ_clust(alpha_rad, 2,true)
[p alpha] = circ_vmpdf(alpha_rad)
circ_plot(alpha_rad,'density','bo',true,'linewidth',2,'color','r'),