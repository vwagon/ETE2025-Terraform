map_list = {
  "http" = ["ingress",80,80,"tcp","0.0.0.0/0"]
  "https" = ["ingress",443,443,"tcp","0.0.0.0/0"]
  "ssh" = ["ingress",22,22,"tcp","0.0.0.0/0"]
  "egress" = ["egress",0,0,"tcp","0.0.0.0/0"]
  "sql" = ["ingress",3306,3306,"tcp","172.31.0.0/16"]
}
