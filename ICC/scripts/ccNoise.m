%Edit them!
start_size=3;
end_size=32;
jump=1;
interval=0.5;
%Edit them!
noise=rand(start_size,start_size);
noise_correlation=fftshift(ifft2(fft2(noise).*conj(fft2(noise))));
correlation_figure=surf(noise_correlation,ones(start_size,start_size,3));
set(correlation_figure,'LineStyle','none')
axis tight;
for ploting_size=start_size:jump:end_size
    noise=rand(ploting_size,ploting_size);
    noise_correlation=fftshift(ifft2(fft2(noise).*conj(fft2(noise))));
    color=zeros(ploting_size,ploting_size,3);
    color(1:2:ploting_size,1:2:ploting_size,:)=0.5;
    color(2:2:ploting_size,2:2:ploting_size,:)=0.5;
    set(correlation_figure,'ZData',noise_correlation,'CData',color);
    pause(interval);
end