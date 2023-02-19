all:
	python3 setup.py sdist bdist_wheel

twine: all
	twine upload dist/*

clean:
	rm -rf dist 
