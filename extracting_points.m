clc;clear all;close all
% load C:\Users\Administrator\Documents\Yonas_Files\Tracking_4x4_multiple\compressed-domain-multi-person-tracking\JM_tracking_4x4_multiple\bin\Hall/points_to_matlab.csv;
% 
% data=points_to_matlab;
% data(:,5)=data(:,5);
% new_Data=data(:,1:2);
% trk_pts=struct('x',{},'y',{},'t',{});
% %%to calculate the minimum distance
% for i =2:max(data(:,5))
%     
%     if(isempty(data(data(:,5)==i,1:2))==0)      
%            curr_data=data(data(:,5)==i-1,1:2);
%            pri_data=data(data(:,5)==i,1:4);
%            curr_data=[curr_data zeros(size(curr_data,1),2)];   
%            for j=1:size(curr_data,1)
%                for k=1:size(pri_data,1) 
%                     distance(k)=sqrt((pri_data(k,3)-curr_data(j,1))^2+(pri_data(k,4)-curr_data(j,2))^2);
%                end
%                if((abs(pri_data(find(distance==min(distance),1,'first'),3)-curr_data(j,1))>32) || (abs(pri_data(find(distance==min(distance),1,'first'),4)-curr_data(j,2))>32))
% %                    trk_pts(1,j).x(i-1,1)=curr_data(j,1);
% %                    trk_pts(1,j).y(i-1,1)=curr_data(j,2);
% %                    trk_pts(1,j).t(i-1,1)=i-1;
% %                    trk_pts(1,j).x(i,1)=curr_data(j,3);
% %                    trk_pts(1,j).y(i,1)=curr_data(j,4);
% %                    trk_pts(1,j).t(i,1)=i;
%                else
%                     curr_data(j,3:4)=pri_data(find(distance==min(distance),1,'first'),1:2);
%                   if (i>2)
%                         flag=0;
%                        for tr=1:size(trk_pts,2)
%                             if (isempty( trk_pts(1,tr).t(:))==0)   
%                                 if( trk_pts(1,tr).t(end)==i-1 && size(curr_data,1)~=1 && trk_pts(1,tr).x(trk_pts(1,tr).t(i-1))== curr_data(j,1) && trk_pts(1,tr).y(trk_pts(1,tr).t(i-1))== curr_data(j,2))
%                                     trk_pts(1,tr).x(i,1)=curr_data(j,3);
%                                     trk_pts(1,tr).y(i,1)=curr_data(j,4);
%                                     trk_pts(1,tr).t(i,1)=i;
%                                     flag=1;
%                                 end
%                             end
%                        end
%                        if(flag==0)
%                                 s=size(trk_pts,2)+1;
%                                 trk_pts(1,s).x(i-1,1)=curr_data(j,1);
%                                 trk_pts(1,s).y(i-1,1)=curr_data(j,2);
%                                 trk_pts(1,s).t(i-1,1)=i-1;
%                                 trk_pts(1,s).x(i,1)=curr_data(j,3);
%                                 trk_pts(1,s).y(i,1)=curr_data(j,4);
%                                 trk_pts(1,s).t(i,1)=i;
%                                 flag=1;
%                        end
%                             
%                        
%                   else
%                       trk_pts(1,j).x(i-1,1)=curr_data(j,1);
%                       trk_pts(1,j).y(i-1,1)=curr_data(j,2);
%                       trk_pts(1,j).t(i-1,1)=i-1;
%                       trk_pts(1,j).x(i,1)=curr_data(j,3);
%                       trk_pts(1,j).y(i,1)=curr_data(j,4);
%                       trk_pts(1,j).t(i,1)=i;
%                    end
%                    
%                end
%                distance=[];
%                
%            end
%         
%     end
%     fprintf('Processing %d out of %d \n',i,max(data(:,5)));
% end
% 
% x_pts=[];
% y_pts=[];
% zz=1;z2=1;
% %% to smooth the trajectory of each key point 
% 
% %load trk_pts
% window=5;
% for q=1: size(trk_pts, 2)
%      trk_pts(1,q).x=trk_pts(1,q).x(trk_pts(1,q).t~= 0);
%      trk_pts(1,q).y=trk_pts(1,q).y(trk_pts(1,q).t~= 0);
%      trk_pts(1,q).t=trk_pts(1,q).t(trk_pts(1,q).t~= 0);
%      
%     if (trk_pts(1,q).x(trk_pts(1,q).t~= 0))
%        trk_pts(1,q).x= medfilt1((trk_pts(1,q).x(trk_pts(1,q).x(1:end-window,1)~=0)),window);
%        trk_pts(1,q).y= medfilt1(trk_pts(1,q).y(trk_pts(1,q).y(1:end-window,1)~=0),window);
%        trk_pts(1,q).t= trk_pts(1,q).t(trk_pts(1,q).t(:,1)~=0);
%     end
% end
% 
% savefile = 'Hall.mat';
% trks = trk_pts(~cellfun(@isempty,{trk_pts.t}));
% save(savefile,'trks')
load Hall.mat
trk_pts=trks;

window=7;
for q=1: size(trk_pts, 2)
     
       trk_pts(1,q).x= medfilt1((trk_pts(1,q).x(trk_pts(1,q).x(1:end-window,1)~=0)),window);
       trk_pts(1,q).y= medfilt1(trk_pts(1,q).y(trk_pts(1,q).y(1:end-window,1)~=0),window);
       trk_pts(1,q).t= trk_pts(1,q).t(trk_pts(1,q).t(:,1)~=0);
    
end
colorVec = hsv(5);
Img=dir('C:\Users\Administrator\Documents\Yonas_Files\Tracking_4x4_multiple\compressed-domain-multi-person-tracking\JM_tracking_4x4_multiple\bin\Hall\*.jpg');
[S,INDEX] =sort_nat({Img.name});
% for i = 1 : length(Img)
%     filename = char(S(i))
%     I = imread(filename);
%     imshow(I);
%     pause
% end

% imshow(I)


for i = 1: length(Img)
    filename = char(S(i+4))
    filename = strcat('C:\Users\Administrator\Documents\Yonas_Files\Tracking_4x4_multiple\compressed-domain-multi-person-tracking\JM_tracking_4x4_multiple\bin\Hall\',filename);
    
    I = imread(filename);
    %I=zeros(size(I,1),size(I,2));
    figure (1),imshow(I)
    hold(imgca, 'on')
    
    for q=1: size(trk_pts, 2)
          %if(trk_pts(1,q).x(trk_pts(1,q).t(:,1)<=r)~=0)
           % plot_on(I,trk_pts(1,q).x(trk_pts(1,q).t(:,1)<=r),trk_pts(1,q).y(trk_pts(1,q).t(:,1)<=r));
          %end
          if(isempty( trk_pts(1,q).x(:))==0)
            si= size(trk_pts(1,q).x(1:end),1);
          
%             plot(trk_pts(1,35).x(1:si,1),trk_pts(1,35).y(1:si,1),'y');
            if(i<si)
                if(trk_pts(1,q).y(trk_pts(1,q).t(1:end)== i))
                      %if(trk_pts(1,q).t(i)~=0)
                      %wx=trk_pts(1,q).x(trk_pts(1,q).t(:,1) ~= 0);
                      %wy=trk_pts(1,q).x(trk_pts(1,q).t(:,1) ~= 0);
                      %plot(imgca,wx,wy,'b');
                      %end
                    u=trk_pts(1,q).x(i+1,1)-trk_pts(1,q).x(i,1);
                    v=trk_pts(1,q).x(i+1,1)-trk_pts(1,q).x(i,1);
                    %quiver(imgca,trk_pts(1,q).x(i,1),trk_pts(1,q).y(i,1),u,v)
                    x= trk_pts(1,q).x(trk_pts(1,q).t== i);
                    y= trk_pts(1,q).y(trk_pts(1,q).t== i);
                    t= trk_pts(1,q).t(trk_pts(1,q).t== i);
                   % plot(x,y,'y');
%                     if(q==165 || q==158 || q==163 )
%                          plot(trk_pts(1,158).x(1:i,1),trk_pts(1,158).y(1:i,1),'m');
                         plot(trk_pts(1,q).x(1:i,1),trk_pts(1,q).y(1:i,1),'y');
%                     end
                  end
                
%                 if(i<=4)
%                     plot(trk_pts(1,1).x(1:i,1),trk_pts(1,1).y(1:i,1),'y');
%                     plot(trk_pts(1,2).x(1:i,1),trk_pts(1,2).y(1:i,1),'r');
%                     plot(trk_pts(1,3).x(1:i,1),trk_pts(1,3).y(1:i,1),'m');
%                     
%                 end
%                 plot(trk_pts(1,4).x(1:i,1),trk_pts(1,10).y(1:i,1),'r');
%                 
%                 plot(trk_pts(1,26).x(2:i,1),trk_pts(1,1).y(2:i,1),'g');
%                 plot(trk_pts(1,27).x(2:i,1),trk_pts(1,2).y(2:i,1),'m');
%                 plot(trk_pts(1,28).x(1:i,1),trk_pts(1,3).y(1:i,1),'w');
%                 plot(trk_pts(1,29).x(1:i,1),trk_pts(1,10).y(1:i,1),'r');
%                 
            end
            end
    %       plot(trk_pts(1,q).x(1:uint8(si/4),1),trk_pts(1,q).y(1:uint8(si/4),1),'b');
    %       plot(trk_pts(1,q).x(uint8(si/4):uint8(si*3/4),1),trk_pts(1,q).y(uint8(si/4):uint8(si*3/4),1),'c')
    %       plot(trk_pts(1,q).x(uint8(si*3/4):end,1),trk_pts(1,q).y(uint8(si*3/4):end,1),'y');
    %       plot(trk_pts(1,q).x(30:50,1),trk_pts(1,q).y(30:50,1),'g')
          
      
    end
    hold off
    tic,pause(0.0001),toc
    %pause
    M(i) = getframe;
end

% 
% %to save the vedio 
video = VideoWriter('Hall.avi', 'MPEG-4');
video.FrameRate = 15;
open(video)
writeVideo(video, M);
close(video);

