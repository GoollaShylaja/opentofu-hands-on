//data is used to read or fetch information from an existing resource or an external source without creating or managing that resource
//Example, we can use data sources to read existing AWS infrastructure, such as Availability Zones, VPCs and subnets, instead of creating them again.

// Fetch data from an API
/*
data	Tells OpenTofu to read existing information.
http	Data source type provided by the HTTP provider.
this	Name given to this data source.
url	    URL from which we want to fetch information.
*/
data "http" "this"{
    url="https://www.google.com/" 
}

// Create a local file using the fetched data and the html_file_name variable from variable.tf file
resource "local_file" "example_http_body" {
  content  = data.http.this.response_body //This accesses the response body returned by the HTTP data source.
  filename = "${path.module}/output_files/${substr(var.html_file_name,0,12)}.html"
}