<h1 align="center" id="title">Enterprise Java Application</h1>
<p id="description">Ensuring a secure environment is crucial during application development. Servers, databases, and other components must be shielded from unauthorized access. In this project, we implement a Bastion Host, also referred to as a "jump box," to enable secure SSH access to our application servers. This configuration places our servers within a private subnet with strictly controlled access.

Additionally, the project introduces the principle of least privilege, meaning user access rights are limited to the essentials required for their tasks.

In a highly available system, application servers are distributed across multiple availability zones. Each zone contains identically configured servers. This setup enables seamless redirection by the application load balancer to servers in another zone if one becomes unavailable. The project includes an Ansible bash script designed to detect and update newly provisioned instances, ensuring they run the latest version from our private Docker Hub repository.</p>
<p id="description">This README document provides a detailed guide, offering you a step-by-step process to effectively implement the Terraform code in this project. This results in the deployment of necessary resources in your AWS environment.

Moreover, this project adheres to modern DevOps best practices, emphasizing automated provisioning, scalability, high availability, and resilience. It enables developers and operators to collaboratively manage and enhance the lifecycle of the Java application, from development to deployment, utilizing the capabilities of AWS infrastructure.

By following these instructions, you will be well-prepared to initiate a sophisticated and adaptable deployment of the Java Application. You'll leverage advanced tools and cloud resources, ensuring optimal outcomes.
</p>
<p id="description">Here is the architectural diagram representing the project's objectives.</p>

![image](https://github.com/Iyewumi-Adesupo/Pet-Adoption-Ansible-Auto_Discovery-Project-/assets/135404420/19a82d45-64f8-41ae-a657-ef055e3f6473)

<p id="description">To deploy this application, I will run terraform apply inside the vault directory, then ssh into the vault using ubuntu, then I will initialize and enable the vault. Below pictures depict the process. </p>

<p id="description"> Then all resources will be provisioned using terraform apply. This is when the vault has been opened. The below pictures show the resources been provisioned, whereby the outputs are generated </p>

![image](https://github.com/Iyewumi-Adesupo/iyewumi-ansible-project/assets/135404420/673575ca-e41d-4767-bfb2-a52b07146114)

<p id="description"> Then I access all the resources on their GUI with the respective ports they listen to. I was able to get token on Sonarqube to add to credentials on Jenkins and also connets Sonarqube to Jenkins using "webhooks". I also made use of Nexus repository to store docker images. Below screenshots show the proceses  </p>

![image](https://github.com/Iyewumi-Adesupo/iyewumi-ansible-project/assets/135404420/ca3c11d0-cb1b-45f5-a49d-eb1f22b5453b)

![image](https://github.com/Iyewumi-Adesupo/iyewumi-ansible-project/assets/135404420/9fde9607-87c6-4263-815e-3060b2726a0d)

<img width="960" alt="sonarQube gui" src="https://github.com/Iyewumi-Adesupo/iyewumi-ansible-project/assets/135404420/5331069e-833f-4425-b0ba-124ed3fe8e6f">

<img width="960" alt="sonarqube token created" src="https://github.com/Iyewumi-Adesupo/iyewumi-ansible-project/assets/135404420/086d26d7-5637-428b-88bd-9672b5d88dff">

<img width="999" alt="sonarqube webhook created" src="https://github.com/Iyewumi-Adesupo/iyewumi-ansible-project/assets/135404420/1b412755-8512-44c8-902b-9e79ac007d53">

<img width="960" alt="nexus gui" src="https://github.com/Iyewumi-Adesupo/iyewumi-ansible-project/assets/135404420/5c6e74f7-d641-4952-be9d-26aeb199d1ab">

<img width="960" alt="nexus security realms" src="https://github.com/Iyewumi-Adesupo/iyewumi-ansible-project/assets/135404420/c2968845-bc5e-4f7b-bc2f-7d73d4ee08a5">

<p id="description"> Then I installed necessary pluggins to run the jenkins pipeline. See below  </p>

<img width="960" alt="pluggins installed successfully" src="https://github.com/Iyewumi-Adesupo/iyewumi-ansible-project/assets/135404420/46de9317-5d31-4825-b9c9-4810ab5a8177">

<p id="description"> Then credentials are being added, system configuration was executed using Sonarqube and its environment variables, and I use tools like Java and Maven to build the pipeline. 

<img width="960" alt="java installation" src="https://github.com/Iyewumi-Adesupo/iyewumi-ansible-project/assets/135404420/46274422-ec35-4742-a54b-d4b80fa8d410">

<img width="960" alt="maven installed" src="https://github.com/Iyewumi-Adesupo/iyewumi-ansible-project/assets/135404420/a45ef655-738e-46a1-a061-4825c9d7dc91">

<img width="960" alt="jenkins credentials created" src="https://github.com/Iyewumi-Adesupo/iyewumi-ansible-project/assets/135404420/0b883a60-7e3e-472f-93e5-e42d8355f47e">

<img width="960" alt="github webhook" src="https://github.com/Iyewumi-Adesupo/iyewumi-ansible-project/assets/135404420/13e42a3d-1d5c-470c-a1c5-ff1bc2eeb966">

![image](https://github.com/Iyewumi-Adesupo/iyewumi-ansible-project/assets/135404420/a18f543e-8096-4bf8-991d-525488f6f9e9)

<p id="description"> Therefore I was able to deploy the pipeline into production environment with all resources provisioned rightly. See below </p>

<img width="960" alt="jenkins pipeline deployed using ansible" src="https://github.com/Iyewumi-Adesupo/iyewumi-ansible-project/assets/135404420/906cc9e2-202a-4c00-b93b-59d5c0024e84">

<img width="919" alt="deploy to prod environment" src="https://github.com/Iyewumi-Adesupo/iyewumi-ansible-project/assets/135404420/760f5a5f-9579-43ec-9e85-17bdd5890cdb">

<p id="description"> I checked if the application was successful using the stage and prod load balancers which were set to the us-west-2 region.  See below </p>

<img width="929" alt="alb stage deployed" src="https://github.com/Iyewumi-Adesupo/iyewumi-ansible-project/assets/135404420/4d00988f-0f2b-4110-8150-74a9b9bbb7fe">

<img width="960" alt="prod alb " src="https://github.com/Iyewumi-Adesupo/iyewumi-ansible-project/assets/135404420/5264bbfa-c9f4-4f9e-adc3-0962418e42eb">

