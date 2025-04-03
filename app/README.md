# 🚀 Application Containerization with Docker

This is a small Java web application developed using the Spring Boot framework. The application serves a simple webpage that displays "iVolve Technologies," "Hello, Spring Boot NTI," and the server's IP address. Additionally, the project features a basic MathService class, complete with unit tests for functionality verification.

## 📌 Table of Contents
- [1️⃣ GitHub Repository Setup](#1️⃣-github-repository-setup)
- [2️⃣ Containerization with Docker](#2️⃣-containerization-with-docker)
  - [🔹 Install Gradle](#-install-gradle)
  - [🔹 Build & Run Application](#-build--run-application)
  - [🔹 SonarQube Integration](#-sonarqube-integration)
  - [🔹 Dockerization](#-dockerization)
  - [🔹 Push Docker Image to DockerHub](#-push-docker-image-to-dockerhub)

---

## 1️⃣ **GitHub Repository Setup**
### 🎯 **Task:**
✅ Create a **GitHub repository** named `CloudDevOpsProject` and initialize it with a **README**.

### 🛠️ **Steps:**
1. Go to [GitHub](https://github.com/).
2. Click on **New Repository**.
3. Name it **CloudDevOpsProject**.
4. Choose **Public** or **Private**.
5. Check **Initialize with a README**.
6. Click **Create Repository**.

### 📌 **Deliverable:**
🔗 Share the **GitHub Repository URL**.

---

## 2️⃣ **Containerization with Docker**
### 🎯 **Task:**
✅ Use the source code from [this repo](https://github.com/IbrahimAdell/FinalProjectCode.git).
✅ Create a **Dockerfile** to containerize the application.

### 🛠️ **Steps:**

### 🔹 **Clone the Repository**
```bash
git clone https://github.com/IbrahimAdell/FinalProjectCode.git
git add .
git commit -m "add source code"
git push origin main
```

---

### 🔹 **Build & Run Application**

1️⃣ **Build JAR File**
```bash
gradle build
```
![Build Success](/assets/app/gradle_build.jpg)

2️⃣ **Run Unit Tests**
```bash
gradle test
```
![Test Results](/assets/app/gradle_test.jpg)

3️⃣ **Run the Application**
```bash
java -jar build/libs/demo-0.0.1-SNAPSHOT.jar
```
![App Running](/assets/app/Run_app.jpg)

🌐 **Access the App:** `http://localhost:8081`

![App UI](/assets/app/localhost.jpg)

---

### 🔹 **SonarQube Integration**

📢 **Install & Run SonarQube Locally**
```bash
sonar-scanner
```
📊 **Analyze Test Results in SonarQube Dashboard**

---

### 🔹 **Dockerization**

📄 **Create a `Dockerfile` in the Project Root:**
```dockerfile
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY build/libs/demo-0.0.1-SNAPSHOT.jar /app/myapp.jar
EXPOSE 8081
CMD ["java", "-jar", "/app/myapp.jar"]
```

📦 **Build the Docker Image:**
```bash
docker build -t my-java-app .
```
![Docker Build](/assets/app/docker_build.jpg)

🐳 **Run the Container:**
```bash
docker run -d -p 8081:8081 my-java-app
```
![Container Running](/assets/app/docker_run.jpg)

✅ **Verify Running Containers**
```bash
docker ps -a
```

🌐 **Access the App in Browser:** `http://localhost:8081`

![Docker App UI](/assets/app/localhost2.jpg)

---

### 🔹 **Push Docker Image to DockerHub**

🔑 **Login to DockerHub**
```bash
docker login
```

📤 **Tag & Push Image to DockerHub**
```bash
docker tag my-java-app:latest abdelhamed4a/java-web-app:v1
docker push abdelhamed4a/java-web-app:v1
```
![Docker Push](/assets/app/docker_push.jpg)

---

## 🎉 **Conclusion**
✅ Successfully **set up a GitHub repository**.
✅ Cloned and **built the application** with **Gradle**.
✅ Integrated **SonarQube** for code analysis.
✅ **Dockerized the application** and **pushed the image to DockerHub**.
✅ Successfully **ran the application inside a container**. 🚀

📌 **Next Steps:** Deploy the Dockerized application to Kubernetes! 🎯

---

