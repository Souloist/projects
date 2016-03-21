from urllib.request import urlopen
from link_finder import LinkFinder
from main import*

class Spider:

	# Spider will get a link off the waiting list, 
	# connect to the link and gather the html which will 
	# be inputted into the link_finder class.

	# we want to create a class variable that stores waitlist/crawled links
	# this way, multiple instances of the spider class can run simultanously 

	project_name = ''
	base_url = ''
	domain_name = ''
	queue_file = ''
	crawled_file = ''

	# Waitlist/crawled list
	queue = set()
	crawled = set()


	def __init__(self, project_name, base_url, domain_name):

		# base_url is the home page

		Spider.project_name =project_name
		Spider.base_url = base_url
		Spider.domain_name = domain_name
		Spider.queue_file = Spider.project_name + '/queue.txt'
		Spider.crawled_file = Spider.project_name + '/crawled.txt'		

		self.boot()
		self.crawl_page("First spider", Spider.base_url)

	@staticmethod # good form, also means your function doesnt need to pass in self
	def boot():
		# boot method will create the project directory and the queue/crawled txt file
		create_project_dir(Spider.project_name)
		create_data_files(Spider.project_name, Spider.base_url)

		# sets new spider to set of urls
		Spider.queue = file_to_set(Spider.queue_file)
		Spider.crawled = file_to_set(Spider.crawled_file)

	@staticmethod
	def crawl_page(thread_name, page_url):

		# Make sure url is not already crawled 
		if page_url not in Spider.crawled:
			print(thread_name + " new crawling " + page_url)
			print("Queue " + str(len(Spider.queue)) + " || Crawled " + str(len(Spider.crawled)))

			# Crawl link on wait list
			Spider.add_links_to_queue(Spider.gather_link(page_url))

			# Remove that url from the waiting list and move to crawled list
			Spider.queue.remove(page_url)
			Spider.crawled.add(page_url)

			# Update que and crawled files
			Spider.update_files()

	@staticmethod
	def gather_link(page_url):

		html_string = ''

		# urlopen returns byte data which we have to turn into a readable string 
		try:
			response = urlopen(page_url)
			
			# make sure it is html data (in case we crawl a pdf file)
			if response.getheader('Content-Type') == 'text/html':
				html_bytes = response.read()
				html_string = html_bytes.decode("utf-a")

			finder = LinkFinder(Spider.base_url, page_url)
			finder.feed(html_string)
		except:
			print('Error: Cannot crawl page')
			# Return empty set if we cannot crawl the link
			return set()

		return finder.page_links()
		
	@staticmethod
	def add_links_to_queue(links):
		for url in links:
			# check to make sure that link does not already exist to waiting link
			if url in Spider.queue:
				continue

			# check to make sure link is not in crawled list
			if url in Spider.crawled:
				continue

			# check if link contains the domain. We dont want to crawl the entire internet
			if Spider.domain_name not in url:
				continue

			Spider.queue.add(url)

	@staticmethod
	def update_files():

		set_to_file(Spider.queue, Spider.queue_file)
		set_to_file(Spider.crawled, Spider.crawled_file)
		

