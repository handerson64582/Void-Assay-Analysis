FILENAME=imread("FILENAMEPATH"); 
gray=rgb2gray(FILENAME); 
grayadjusted=imadjust(gray); 
binary=grayadjusted>120; %CAN CHANGE THRESHOLD VALUE 
figure 
subplot(1,5,1); imshow(FILENAME); title('Original') 
subplot(1,5,2); imshow(gray); title('Grayscale') 
subplot(1,5,3); imshow(grayadjusted); title('Adjusted') 
subplot(1,5,4); imshow(binary); title('Binary') 
binary=imfill(binary,"holes"); 
subplot(1,5,5); imshow(binary); title('No Holes') 
sgtitle('FILENAME') 
props=regionprops(binary,'Area'); 
sortarea=sort([props.Area],'descend'); 
counted=bwareaopen(binary, 2404); %CAN CHANGE PIXEL FILTERING: Please note that 2404 pixels is 1 uL threshold. Can reference PDF for desired volume thresholds or calculate via f1 and f2.
[label,numShape]=bwlabel(counted,8); 
fprintf('MATLAB found %d shapes in FILENAME.\n',numShape) 
areapixels=bwarea(binary); 
fprintf('Total area of voiding is %d pixels in FILENAME.\n', areapixels) 
areacm=f1(areapixels); 
fprintf('Total area of voiding is %d sq cm in FILENAME.\n',areacm) 
volumeuL=f2(areacm); 
fprintf('Total volume of voiding is %d uL in FILENAME.\n',volumeuL) 

%%
function f1=lineartrendline(x) 
m1 = 6.5316e-05; 
b1 = -4.0538e-15; 
f1=m1*x+b1; %where f1 is sq cm and x is pixels 
end 
function f2=lineartrendline2(x) 
m2 = 17.6147; 
b2 = -2.1641; 
f2=m2*x+b2; %where f2 is uL and x is sq cm 
end