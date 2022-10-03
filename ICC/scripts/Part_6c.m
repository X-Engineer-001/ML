%Part a
scene=imread('Scene.bmp');
scene=im2double(scene);
scene=scene(:,:,1);
target=imread('letter_e.bmp');
target=im2double(target);
target=target(:,:,1);
[height,width]=size(target);
half_height=floor(height/2);
half_width=floor(width/2);
correlation=zeros(1024,1024);
for i=1:1024-height+1
    for j=1:1024-width+1
        window=scene(i:i+height-1,j:j+width-1);
        correlation(i,j)=sum(sum(window.*target));
    end
end
%Part a
%Part c
imshow(scene);
for i=1:1024
    for j=1:1024
        if correlation(i,j)>=1000
            rectangle('Position',[j,i,width,height],'EdgeColor',[1 0 0],'LineWidth',3);
        end
    end
end
%Part c