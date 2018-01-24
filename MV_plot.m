clc;close all;clear
load  C:\Users\Administrator\Documents\Yonas_Files\Tracking_4x4_multiple\compressed-domain-multi-person-tracking\JM_tracking_4x4_multiple\bin\PETS/points_to_matlab.csv;

data=points_to_matlab;
new_Data=data(:,1:2);
ImgfileDir='C:\Users\Administrator\Documents\Yonas_Files\Tracking_4x4_multiple\compressed-domain-multi-person-tracking\JM_tracking_4x4_multiple\bin\PETS/'

Img=dir('C:\Users\Administrator\Documents\Yonas_Files\Tracking_4x4_multiple\compressed-domain-multi-person-tracking\JM_tracking_4x4_multiple\bin\PETS/*.jpg');
[S,INDEX] =sort_nat({Img.name});
figure
for i = min(data(:,5)):max(data(:,5))
    
    filename = char(S(i));
    filename = strcat(filename);
    I = imread([ImgfileDir filename]);
    subplot(2,2,[1 2])
    imshow(I)
    %I=zeros(size(I,1),size(I,2));
   
    d=data(data(:,5)==i,1:4);
    for q=1:size(d,1)
            u=d(q,1)-d(q,3);
            v=d(q,2)-d(q,4);
            r=[u,v];
            magnitude(q,1)=norm(r);
            magnitude(q,2)=atan2d(v,u);
            
    end
%     magnitude(:,1)=medfilt1(magnitude(:,1),5);
%     for q=1:size(d,1)
%            d(q,3)=floor(d(q,1) - magnitude(q,1)*cosd(magnitude(q,2)));
%            d(q,4)=floor(d(q,2) - magnitude(q,1)*sind(magnitude(q,2)));
%     end
    
    alpha_rad = circ_ang2rad( magnitude(:,2));
    
    subplot(2,2,3)
    circ_plot(alpha_rad,'pretty','bo',true,'linewidth',2,'color','r'),

    subplot(2,2,4)
    circ_plot(alpha_rad,'hist',[],20,true,true,'linewidth',2,'color','r')
    
%     alpha_bar = circ_rad2ang(circ_mean(alpha_rad))
%     R_alpha = circ_r(alpha_rad);
    
%     if(size(alpha_rad,1) > 2 && R_alpha < 0.75)
%        circ_clust(alpha_rad,2,true);
%     end
   
    
%     hold(imgca, 'on')
%         for q=1:size(d,1)
%             u=d(q,1)-d(q,3);
%             v=d(q,2)-d(q,4);
%             quiver(imgca,d(q,3),d(q,4),u,v,'color',[0 0 1])
% %             if j==0
% %                 quiver(imgca,d(q,3),d(q,4),u,v,'color',[0 0 1])
% %             elseif j==1
% %                 
% %                  quiver(imgca,d(q,3),d(q,4),u,v,'color',[1 0 0])
% %             elseif j==2
% %                 quiver(imgca,d(q,3),d(q,4),u,v,'color',[0 1 0])
% %             elseif j==3
% %                  quiver(imgca,d(q,3),d(q,4),u,v,'color',[0 1 1])
% %                     
% %             end
% %                     
% %             plot(d(q,1),d(q,2),'y');
%         end
%     hold off
    
    tic,pause(0.01),toc
    %pause
    M(i) = getframe;
    clf
end
% video = VideoWriter('Walking3.avi', 'MPEG-4');
% video.FrameRate = 15;
% open(video)
% writeVideo(video, M);
% close(video);
