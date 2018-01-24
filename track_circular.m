clc;clear all;close all
load C:\Users\Administrator\Documents\Yonas_Files\Tracking_4x4_multiple\compressed-domain-multi-person-tracking\JM_tracking_4x4_multiple\bin\Hall/points_to_matlab.csv;
ImgfileDir='C:\Users\Administrator\Documents\Yonas_Files\Tracking_4x4_multiple\compressed-domain-multi-person-tracking\JM_tracking_4x4_multiple\bin\Hall/'

Img=dir('C:\Users\Administrator\Documents\Yonas_Files\Tracking_4x4_multiple\compressed-domain-multi-person-tracking\JM_tracking_4x4_multiple\bin\Hall/*.jpg');
[S,INDEX] =sort_nat({Img.name});

data=points_to_matlab;
data(:,5)=data(:,5);
new_Data=data(:,1:2);
trk_pts=struct('x',{},'y',{},'t',{});
figure (1)
figure (3)
%%to calculate the minimum distance
for i =2:max(data(:,5))
    
    filename = char(S(i));
    filename = strcat(filename);
    I = imread([ImgfileDir filename]);
    figure (1),imshow(I)
    
    
    if(isempty(data(data(:,5)==i,1:2))==0)
        
           d=data(data(:,5)==i,1:4);
            for q=1:size(d,1)
                    u=d(q,1)-d(q,3);
                    v=d(q,2)-d(q,4);
                    r=[u,v];
                    magnitude(q,1)=norm(r);
                    magnitude(q,2)=atand(v/u);
            end
    %magnitude(:,1)=medfilt1(magnitude(:,1),5);
    for q=1:size(d,1)
           d(q,3)=floor(d(q,1) - magnitude(q,1)*cosd(magnitude(q,2)));
           d(q,4)=floor(d(q,2) - magnitude(q,1)*sind(magnitude(q,2)));
    end
            hold(imgca, 'on')
                for q=1:size(d,1)
                    u=d(q,1)-d(q,3);
                    v=d(q,2)-d(q,4);
                    quiver(imgca,d(q,3),d(q,4),u,v,'color',[0 0 1])

                end
            alpha_rad = circ_ang2rad( magnitude(:,2));
            figure (3);
            subplot(1,2,1)
            circ_plot(alpha_rad,'pretty','bo',true,'linewidth',2,'color','r'),

            subplot(1,2,2)
            circ_plot(alpha_rad,'hist',[],20,true,true,'linewidth',2,'color','r')

            alpha_bar = circ_mean(alpha_rad);
            R_alpha = circ_r(alpha_rad)

            if(size(alpha_rad,1) > 2 && R_alpha < 0.75)
               circ_clust(alpha_rad,2,true);
            end

           
           
           curr_data=data(data(:,5)==i-1,1:2);
           pri_data=d;
           curr_data=[curr_data zeros(size(curr_data,1),2)];   
           for j=1:size(curr_data,1)
               for k=1:size(pri_data,1) 
                    distance(k)=sqrt((pri_data(k,3)-curr_data(j,1))^2+(pri_data(k,4)-curr_data(j,2))^2);
               end
               if((abs(pri_data(find(distance==min(distance),1,'first'),3)-curr_data(j,1))>32) || (abs(pri_data(find(distance==min(distance),1,'first'),4)-curr_data(j,2))>32))
%                    trk_pts(1,j).x(i-1,1)=curr_data(j,1);
%                    trk_pts(1,j).y(i-1,1)=curr_data(j,2);
%                    trk_pts(1,j).t(i-1,1)=i-1;
%                    trk_pts(1,j).x(i,1)=curr_data(j,3);
%                    trk_pts(1,j).y(i,1)=curr_data(j,4);
%                    trk_pts(1,j).t(i,1)=i;
               else
                    curr_data(j,3:4)=pri_data(find(distance==min(distance),1,'first'),1:2);
                  if (i>2)
                        flag=0;
                       for tr=1:size(trk_pts,2)
                            if (isempty( trk_pts(1,tr).t(:))==0)   
                                if( trk_pts(1,tr).t(end)==i-1 && size(curr_data,1)~=1 && trk_pts(1,tr).x(trk_pts(1,tr).t(i-1))== curr_data(j,1) && trk_pts(1,tr).y(trk_pts(1,tr).t(i-1))== curr_data(j,2))
                                    trk_pts(1,tr).x(i,1)=curr_data(j,3);
                                    trk_pts(1,tr).y(i,1)=curr_data(j,4);
                                    trk_pts(1,tr).t(i,1)=i;
                                    flag=1;
                                end
                            end
                       end
                       if(flag==0)
                                s=size(trk_pts,2)+1;
                                trk_pts(1,s).x(i-1,1)=curr_data(j,1);
                                trk_pts(1,s).y(i-1,1)=curr_data(j,2);
                                trk_pts(1,s).t(i-1,1)=i-1;
                                trk_pts(1,s).x(i,1)=curr_data(j,3);
                                trk_pts(1,s).y(i,1)=curr_data(j,4);
                                trk_pts(1,s).t(i,1)=i;
                                flag=1;
                       end
                            
                       
                  else
                      trk_pts(1,j).x(i-1,1)=curr_data(j,1);
                      trk_pts(1,j).y(i-1,1)=curr_data(j,2);
                      trk_pts(1,j).t(i-1,1)=i-1;
                      trk_pts(1,j).x(i,1)=curr_data(j,3);
                      trk_pts(1,j).y(i,1)=curr_data(j,4);
                      trk_pts(1,j).t(i,1)=i;
                      
                   end
                   
               end
               distance=[];
               
           end
        
    end
    hold off
    fprintf('Processing %d out of %d \n',i,max(data(:,5)));
end


