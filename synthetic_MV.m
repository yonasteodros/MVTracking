clc;clear all;close all
x1=[10 25 40 55 70 85 100 115 130 145 160];u1=x1+10;
t=[1:11];
y1=10*ones(size(x1));v1=y1;
trk_pt1=[x1' y1' u1' v1' t'];
x2=x1+32;u2=x2+10;
y2=20*ones(size(x2));v2=y2;
trk_pt2=[x2' y2' u2' v2' t'];
x3=x2+32;u3=x3+10;
y3=30*ones(size(x3));v3=y3;
trk_pt3=[x3' y3' u3' v3' t'];
data=[]
for k=1:11
da=[ trk_pt1(k,:) ; trk_pt2(k,:); trk_pt3(k,:)];
data=[data ;  da]
end

I = imread('black.jpg');
figure (1),imshow(I)
hold(imgca, 'on')
% for i=1:size(x1,2)
%     for j=1:3
%         p=x(j,i);
%         w=y(j,i);
%         u=10;
%         v=0;
%         quiver(p,w,u,v)
% 
%     end
% 
% end
% hold off
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
               if((abs(pri_data(find(distance==min(distance),1,'first'),3)-curr_data(j,1))>126) || (abs(pri_data(find(distance==min(distance),1,'first'),4)-curr_data(j,2))>126))
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
    
end

x_pts=[];
y_pts=[];
zz=1;z2=1;
%load trk_pts
% for q=1: size(trk_pts, 2)
%     trk_pts(1,q).x=trk_pts(1,q).x(trk_pts(1,q).t~= 0);
%     trk_pts(1,q).y=trk_pts(1,q).y(trk_pts(1,q).t~= 0);
%     trk_pts(1,q).t=trk_pts(1,q).t(trk_pts(1,q).t~= 0);
%     
%  %   trk_pts(1,q).x= medfilt1((trk_pts(1,q).x(trk_pts(1,q).x(:,1)~=0)),3);
%  %   trk_pts(1,q).y= medfilt1(trk_pts(1,q).y(trk_pts(1,q).y(:,1)~=0),3);
%  %   trk_pts(1,q).t= trk_pts(1,q).t(trk_pts(1,q).t(:,1)~=0);
% end

savefile = 'synthetic.mat';
trk_pts = trk_pts(~cellfun(@isempty,{trk_pts.t}));
save(savefile,'trk_pts')
load synthetic.mat
colorVec = hsv(5);
Img=dir('C:\Users\Administrator\Documents\Yonas_Files\Tracking_4x4_multiple\compressed-domain-multi-person-tracking\JM_tracking_4x4_multiple\bin\synthetic\*.jpg');
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
    filename = strcat('C:\Users\Administrator\Documents\Yonas_Files\Tracking_4x4_multiple\compressed-domain-multi-person-tracking\JM_tracking_4x4_multiple\bin\synthetic\',filename);
    I = imread(filename);
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
                      % wx=trk_pts(1,q).x(trk_pts(1,q).t(:,1) ~= 0);
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
                    
                    plot(trk_pts(1,q).x(1:i,1),trk_pts(1,q).y(1:i,1),'y');
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
    pause
    

end
