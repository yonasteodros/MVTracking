clc;clear all;close all
load C:\Users\Administrator\Documents\Yonas_Files\Tracking_4x4_multiple\compressed-domain-multi-person-tracking\JM_tracking_4x4_multiple\bin\walking2/points_to_matlab.csv;
data=points_to_matlab;
%data(:,5)=data(:,5)/4;
new_Data=data(:,1:2);
trk_in=1;
trk_pts=struct('x',{},'y',{},'t',{});
%%to calculate the minimum distance
for i =2:max(data(:,5))
    if(isempty(data(data(:,5)==i,1:2))==0)      
           curr_data=data(data(:,5)==i-1,1:2);
           pri_data=data(data(:,5)==i,1:4);
           curr_data=[curr_data zeros(size(curr_data,1),2)];   
           for j=1:size(curr_data,1)
               for k=1:size(pri_data,1) 
                    distance(k)=sqrt((pri_data(k,3)-curr_data(j,1))^2+(pri_data(k,4)-curr_data(j,2))^2);
               end
               if((abs(pri_data(find(distance==min(distance),1,'first'),3)-curr_data(j,1))>16) || (abs(pri_data(find(distance==min(distance),1,'first'),4)-curr_data(j,2))>16))

               else
                   curr_data(j,3:4)=pri_data(find(distance==min(distance),1,'first'),1:2);
                   trk_pts(1,j).x(i-1,1)=curr_data(j,1);
                   trk_pts(1,j).y(i-1,1)=curr_data(j,2);
                   trk_pts(1,j).t(i-1,1)=i-1;
                   trk_pts(1,j).x(i,1)=curr_data(j,3);
                   trk_pts(1,j).y(i,1)=curr_data(j,4);
                   trk_pts(1,j).t(i,1)=i;
                   trk_in= trk_in+1;
               end
               distance=[];
           end
           
        
    end
    
end
x_pts=[];
y_pts=[];
zz=1;z2=1;

for q=1: size(trk_pts, 2)
    %trk_pts(1,q).x= medfilt1((trk_pts(1,q).x(trk_pts(1,q).x(:,1)~=0)),2);
    %trk_pts(1,q).y= medfilt1(trk_pts(1,q).y(trk_pts(1,q).y(:,1)~=0),2);
    %trk_pts(1,q).t= trk_pts(1,q).t(trk_pts(1,q).t(:,1)~=0);
end
colorVec = hsv(5);
figure
%Img=dir('*.jpg');
Img=dir('C:\Users\Administrator\Documents\Yonas_Files\Tracking_4x4_multiple\compressed-domain-multi-person-tracking\JM_tracking_4x4_multiple\bin\walking2\*.jpg');
[S,INDEX] =sort_nat({Img.name});
% for i = 1 : length(Img)
%     filename = char(S(i))
%     I = imread(filename);
%     imshow(I);
%     pause
% end

% imshow(I)
   
for i = 1: length(Img)
    filename = char(S(i))
    filename = strcat('C:\Users\Administrator\Documents\Yonas_Files\Tracking_4x4_multiple\compressed-domain-multi-person-tracking\JM_tracking_4x4_multiple\bin\walking2\',filename);
    I = imread(filename);
    imshow(I)
    hold on
    
    for q=1: size(trk_pts, 2)
          %if(trk_pts(1,q).x(trk_pts(1,q).t(:,1)<=r)~=0)
           % plot_on(I,trk_pts(1,q).x(trk_pts(1,q).t(:,1)<=r),trk_pts(1,q).y(trk_pts(1,q).t(:,1)<=r));
          %end
          
            si= size(trk_pts(1,q).x(1:end,1),1);
%             plot(trk_pts(1,35).x(1:si,1),trk_pts(1,35).y(1:si,1),'y');
            if(i<si)
                plot(trk_pts(1,1).x(2:i,1),trk_pts(1,1).y(2:i,1),'b');
  %              plot(trk_pts(1,2).x(2:i,1),trk_pts(1,2).y(2:i,1),'c');
 %                plot(trk_pts(1,3).x(1:i,1),trk_pts(1,3).y(1:i,1),'y');
%                 plot(trk_pts(1,4).x(1:i,1),trk_pts(1,10).y(1:i,1),'r');
%                 
%                 plot(trk_pts(1,26).x(2:i,1),trk_pts(1,1).y(2:i,1),'g');
%                 plot(trk_pts(1,27).x(2:i,1),trk_pts(1,2).y(2:i,1),'m');
%                 plot(trk_pts(1,28).x(1:i,1),trk_pts(1,3).y(1:i,1),'w');
%                 plot(trk_pts(1,29).x(1:i,1),trk_pts(1,10).y(1:i,1),'r');
%                 
            end
    %       plot(trk_pts(1,q).x(1:uint8(si/4),1),trk_pts(1,q).y(1:uint8(si/4),1),'b');
    %       plot(trk_pts(1,q).x(uint8(si/4):uint8(si*3/4),1),trk_pts(1,q).y(uint8(si/4):uint8(si*3/4),1),'c')
    %       plot(trk_pts(1,q).x(uint8(si*3/4):end,1),trk_pts(1,q).y(uint8(si*3/4):end,1),'y');
    %       plot(trk_pts(1,q).x(30:50,1),trk_pts(1,q).y(30:50,1),'g')
          
         
    end
    hold off
    pause
    
end


