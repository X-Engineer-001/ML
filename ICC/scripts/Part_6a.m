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
tic;
for i=1:1024-height+1
    for j=1:1024-width+1
        window=scene(i:i+height-1,j:j+width-1);
        correlation(i,j)=sum(sum(window.*target));
    end
end
toc;