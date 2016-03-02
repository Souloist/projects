import os

# apparently dir is a key word
def create_project_dir(directory):

	# create new directory if one doesnt exist
	if not os.path.exists(directory):
		print("Creating project: " + directory)
		os.makedirs(directory)

def create_data_files(project_name, base_url):

	# queue of webpages that have not been crawled
	queue = project_name + "queue.txt"

	# list of webpages that have been crawled
	crawled = project_name + "crawled.txt"

	if not os.path.isfile(queue):

		# make sure queue isnt empty to start otherwise sypder will never crawl
		write_file(queue, base_url)
	if not os.path.isfile(crawled):
		write_file(crawled, '')

# creates new file
def write_file(path, data):
	f = open(path, 'w')
	f.write(data)

	# close to prevent data leak
	f.close()
