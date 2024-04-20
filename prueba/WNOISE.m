function [w,t]=WNOISE(Pn,t)

w=sqrt(Pn)*randn(size(t)); w=w(:);
