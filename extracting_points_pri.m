clc;clear all;close all
load points_to_matlab.csv;
data=points_to_matlab;
data(:,5)=data(:,5)/4;
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
Img=dir('*.jpg');
% figure
% for i = 1 : length(Img)
%     filename = Img(i).name;
%     I = imread(filename);
% %     imshow(I);
% %     pause
% end
for q=1: size(trk_pts, 2)
    trk_pts(1,q).x= medfilt1((trk_pts(1,q).x(trk_pts(1,q).x(:,1)~=0)),5);
    trk_pts(1,q).y= medfilt1(trk_pts(1,q).y(trk_pts(1,q).y(:,1)~=0),5);
    trk_pts(1,q).t= trk_pts(1,q).t(trk_pts(1,q).t(:,1)~=0);
end

% for r=1:length(Img)
%     filename = Img(r).name;
%     I = imread(filename);
% %     imshow(I)
%     for q=1: size(trk_pts, 2)
%        
%       plot_on(I,trk_pts(1,q).x(trk_pts(1,q).t(:,1)<=r),trk_pts(1,q).y(trk_pts(1,q).t(:,1)<=r));
%       pause
%     end
%           
%        
% end


