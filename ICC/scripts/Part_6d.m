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
tic
correlation=ifft2(fft2(scene).*conj(fft2(target,1024,1024))); 
toc
%Part a
%Part b
figure(1);
plot(correlation);
axis tight
figure(2);
plot(correlation');
axis tight
figure(3);
x=[1:1024];
y=[1024:-1:1];
set(surf(x,y,correlation,correlation),'LineStyle','none');
axis tight
%Part b
%Part c
figure(4);
imshow(scene);
for i=1:1024
    for j=1:1024
        if correlation(i,j)>=1000
            rectangle('Position',[j,i,width,height],'EdgeColor',[1 0 0],'LineWidth',3);
        end
    end
end
%Part c