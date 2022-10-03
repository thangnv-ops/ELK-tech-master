##############  Lab 1.
mkdir ~/data
git clone https://github.com/thangnguyen1705/ELK-tech-master.git
cd ~/data/ELK-tech-master/Lesson-1/elasticsearch-single
docker-compose up -d

############## Kiểm tra kết quả
curl http://127.0.0.1:9200

############## Lab 2.  Tạo index
curl -X PUT "localhost:9200/tech-master?pretty"
# Check index đã tạo
curl -X GET "localhost:9200/tech-master?pretty"

############## Xóa elasticsearch single
cd ~/data/ELK-tech-master/Lesson-1/elasticsearch-single
docker-compose down -v

############## Lab 4. Tao elasticsearch cluster
cd ~/data/ELK-tech-master/Lesson-1/elasticsearch-cluster
docker-compose up -d

############## Lab 5. Tao index với shards và replicas
curl -X PUT "localhost:9200/tech-master?pretty" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "index": {
      "number_of_shards": 3,  
      "number_of_replicas": 1
    }
  }
}
'
# Check index đã tạo
curl -X GET "localhost:9200/tech-master?pretty"


############## Lab 6. Update cài đặt index
curl -X PUT "localhost:9200/tech-master/_settings?pretty" -H 'Content-Type: application/json' -d'
{
  "index" : {
    "number_of_replicas" : 0
  }
}'


############## Lab 7. POST document vào index
curl -X POST "localhost:9200/tech-master/_doc/?pretty" -H 'Content-Type: application/json' -d'
{
  "@timestamp": "2099-11-15T13:12:00",
  "message": "GET /search HTTP/1.1 200 1070000",
  "user": {
    "id": "kimchy"
  }
}
'
# Search document 
curl -X GET "localhost:9200/tech-master/_search?pretty" -H 'Content-Type: application/json' -d'
{
  "query": {
    "match": {
      "user.id": "kimchy"
    }
  }
}
'

############## Lab 8. POST file vào index
curl -H 'Content-Type: application/json' -XPOST 'localhost:9200/tech-master/_doc?pretty' --data-binary @data.json

############## Lab 9. Đánh ID cho document
curl -X POST "localhost:9200/tech-master/_doc/555?pretty" -H 'Content-Type: application/json' -d'
{
  "@timestamp": "2099-11-15T13:12:00",
  "message": "GET /search HTTP/1.1 200 1070000",
  "user": {
    "id": "kimchy"
  }
}'

