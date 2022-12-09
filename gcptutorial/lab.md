Here are the images of the lab that I did on Coursera:

1. The following image shows the modules have been initialized.

![image](https://user-images.githubusercontent.com/21220549/206695023-86b5792e-75aa-451b-95d5-36283ae5371a.png)

**2. network = google_compute_network.mynetwork.self_link**

A really important concept which instructs Terraform to create resources in a dependent order. 
When we use this parameter, Terraform will create the network first and then the firewall rules. The instances will be created after that. 
As we know, when there will be a network, then we would be able to create the instance. It means a vm instance depends on the network. A network should be created before
the VM. 
