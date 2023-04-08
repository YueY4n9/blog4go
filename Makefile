dev:
	hexo clean && hexo g && hexo s -p 80
deploy:
	hexo clean && hexo g && hexo d