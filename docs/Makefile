default: docs
docs:
	@rm -rf doxyYoda*
	@wget https://github.com/HaoZeke/doxyYoda/releases/download/0.0.2/doxyYoda_0.0.2.tar.gz
	@tar -xf doxyYoda_0.0.2.tar.gz
	#@wget https://github.com/HaoZeke/doxyYoda/releases/download/v0.1.3/doxyYoda_0.1.3.tar.gz
	#@tar xf doxyYoda_0.1.3.tar.gz
	@doxygen Doxyfile-this.in

clean:
	rm -rf doxyYoda*
	rm -rf html
