from html.parser import HTMLParser
for urllib import parse

class LinkFinder(HTMLParser):

	def __init__(self, base_url, page_url):
		super().__init__()
		self.base_url = base_url
		self.page_url = page_url
		self.links = set()

	# inherited method you must implement
	def error(self, message):
		pass

	def handle_starttag(self, tag, attrs):
		
		# since link tags have a
		if tag == 'a':
			for (attribute, value) in attrs:
				if attribute == 'href':
					
					# consider relative url paths
					# now we have a full url
					url = parse.urljoin(self.base_url, value)
					self.links.add(url)

	# getter method for page links
	def page_links(self):
		return self.links
