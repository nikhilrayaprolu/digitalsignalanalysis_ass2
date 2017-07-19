function image=DenoiseImage(file)
im=imread('twigs.png');
a=fftshift(fft2(im));
imshow(a);
   twigs=im2double(a);

    image=mat2gray(log(abs(twigs)+1));
    imshow(image);

filterize=ones(253,256,3);
filterize(125:129,1:87,1:3)=zeros(5,87,3);
filterize(1:86,128:131,1:3)=zeros(86,4,3);
filterize(125:129,170:256,1:3)=zeros(5,87,3);
filterize(170:253,128:131,1:3)=zeros(84,4,3);
a=a.*filterize;
a=ifftshift(a);
a=uint8(ifft2(a));
image=a;
imshow(image);
end
