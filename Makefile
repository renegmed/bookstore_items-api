init-project:
	go mod init bookstore_items-api

tag:
	git tag 1.0.0
	git push origin 1.0.0

# build:
# 	docker build -t bookstore-items-api . 

# run: 
# 	docker run -d -p 8081:8081 -env ELASTIC_HOSTS="" --name items-api bookstore-items-api

go-build:
	go build -race -o items_api main.go 

go-run:	go-build
#./items_api -a localhost:8085 -e http://127.0.0.1:9200
	./items_api -a localhost:8085 -e http://127.0.0.1:9200
# prune:
# 	docker system prune 

ping:
	curl localhost:8084/ping 	

create-index:
	curl -XPUT localhost:9200/items -v -H 'Content-type: application/json' -d '{"settings": {"index": {"number_of_shards":4, "number_of_replicas": 2} } }'

get-index:
	curl localhost:9200/items	
search-index:
	curl localhost:9200/_search

#type Item struct {
#	Id                string      `json:"id"`
#	Seller            int64       `json:"seller"`
#	Title             string      `json:"title"`
#	Description       Description `json:"description"`
#	Pictures          []Picture   `json:"pictures"`
#	Video             string      `json:"video"`
#	Price             float32     `json:"price"`
#	AvailableQuantity int         `json:"available_quantity"`
#	SoldQuantity      int         `json:"sold_quantity"`
#	Status            string      `json:"status"`
#}
# post:
# 	curl -XPOST localhost:8084/items -d '{"id":"123456", "seller":"Seller A", "title":"manager","description":"any description","video":"/home/video/12345.mov", "price":154.75, "available_quantity":5,"sold_quantity":1, "status":"available"}'


post-item:
	curl -XPOST localhost:8084/items?access_token=abc134 -H 'Content-type: application/json' \
		 -d '{"id":"123456", "seller":"Seller A", "title":"this is the title","description":{"plain_text":"text description"},"video":"/home/video/12345.mov","price":154.75, "status": "pending", "available_quantity": 10 }'