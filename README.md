# One2n Assignment Task: Create a Kubernetes cron job that pulls node metrics like (CPU, Memory, Disk usage) and stores them in a file.

#### Pre requisite:
  - Kubernetes cluster (For local kubernetes Cluster, I am using minikube in my local machine.)
  - node exporter daemonset for collecting and exposing metric to kube api server which is required for the application.

#### Project Folder structure required for task workflow :
  - Cron Job Application is created using bash-script, code reside in metrics. sh file.
  - We have used Docker to dockerized/containerised the above application, written and maintained Dockerfile file.
  - Created Directory kubernetes , where all k8s manifests file are present which includes: cronjob, pv,pvc, node-exporter, secrets.

#### Application Code (metrics.sh):
  - Variables added:
      - NODE_ EXPORTER_URL: URL for Node Exporter metrics, defaulting to http://$ (minikube ip):9100/metrics.
      - OUTPUT_ DIR: Directory to store metrics, defaulting to /data/metrics.
  - node exporter will be used here in the script for node_cpu_seconds_total, node_memory_Mem, and node_disk.
  - The application is used to create a file which stores the data for metrics fetched from node-exporter daemonset, everytime the cron job is executed it created a new file with UTC timestamp in the format YYYYMMDDHHMMSS using date +"%Y%m%d%H%M%S".
  - The output file path is OUTPUT_DIR/metrics_$timestamp.txt and its getting stored inside the pod "/data/metrics" and minikube node.

#### Dockerfile :
  - Using a lightweight base image : alpine:3.18 without installing any default and irrelvant dependencies only installed bash & curl.
  - Using copy keyword transferring the metrics.sh file inside my container and giving execution mode so that the bash file can be executed easily.
  - Setting OUTPUT_DIR to /data/metrics inside the container.
  - At the end of the file using default command to run the metrics.sh script using bash -c.

#### Kubernetes manifest files inside (kubernetes directory)
  - files inside the folder:
      - metric-cron.yaml: this file includes code for cron job which execute the application for fetching the node metrics and storing the same by creating new file with timestamp.
      - metric-pvc.yaml: this file includes code for persistent volume claim for the pod so that our data file is persist if any restart or rescheduled of the pod
      - node-exporter-url-secret.yaml: this file includes code for having the secret which has base64 encoded url of the node exporter running in the cluster. this is getting injected in the metric-cron.yaml as ref.
      - metric-pv.yaml: this file includes code for persistent volume which is synced with the pvc for having a persistent volume.
      - node-exporter-install.yaml: this file includes code installing the node exporter daemonset which get utilised by the application and k8s files.
   
#### Assumptions made accross the task:
  - Used UTC timezone for creating files name.
  - Used /data/metrics path for minikube node which will be sync with the pod directory also. (sudo mkdir -p/data/metrics && sudo chmod -R 777 /data/metrics inside minikube node)..


#### Video for references

  - PART 1 :


https://github.com/user-attachments/assets/3287e028-256c-402e-aa87-3f9dfc6e3f58



  - PART 2 : 


https://github.com/user-attachments/assets/13b0f83a-5574-4503-b34b-d20bea5613c3

