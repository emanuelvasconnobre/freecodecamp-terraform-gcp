**Project README**

### Objective of the Project:
This project serves as a practical introduction to Terraform, showcasing its integration with Google Cloud Platform (GCP) as the provider for infrastructure provisioning and management. The Terraform configurations define the setup of various resources within GCP, including the configuration of a custom domain using Cloud DNS. This facilitates straightforward deployment and maintenance.

### Prerequisites:
Before running the project, ensure you have the following prerequisites in place:

1. **Terraform Installation:**
   Ensure that Terraform is installed on your local machine. You can download the latest version from the official Terraform website: [Terraform Downloads](https://www.terraform.io/downloads.html).

2. **Google Cloud Platform (GCP) Account:**
   Have an active GCP account with the required credentials and permissions for resource creation and management. Set up a GCP project and obtain the necessary authentication credentials.

3. **Service Account Key:**
   Create a service account key on GCP and download the associated JSON key file. This key file will be utilized by Terraform for authentication with GCP. Store the key file securely.

4. **GCP Cloud DNS Configuration:**
   Ensure that Cloud DNS is configured in your GCP project. Follow the steps below:

    a. Open the GCP Console and navigate to the **Cloud DNS** section.

    b. Create a new DNS zone for your domain, specifying the desired domain name.

    c. Note the DNS zone name, as you will use it as a variable in the Terraform configuration.

5. **Configure Variables:**
   Create a file named `terraform.tfvars` and configure the necessary variables specified in the `variables.tf` file. Include values such as the GCP project ID, region, service account key file path, DNS zone name, and domain name. Example `terraform.tfvars`:

    ```hcl
    gcp_svc_key     = "/path/to/your/keyfile.json"
    gcp_project     = "your-gcp-project-id"
    gcp_region      = "us-central1"
    dns_zone_name   = "your-dns-zone-name"
    ```

6. **Apply the Terraform Configuration:**
   Apply the Terraform configuration to create the defined infrastructure. Review the changes and confirm by entering `yes` when prompted.

    ```bash
    terraform apply
    ```

   Terraform will provision the specified resources on GCP, including the configuration of the custom domain using Cloud DNS.

7. **Destroy the Infrastructure (Optional):**
   If needed, you can destroy the created infrastructure using the following command:

    ```bash
    terraform destroy
    ```

   Confirm the destruction by entering `yes` when prompted.

**Note:** Be cautious when using `terraform destroy` as it will permanently delete the specified resources.

Feel free to customize the project according to your requirements and extend the Terraform configurations as needed. For more information on Terraform, GCP, and Cloud DNS, refer to the official documentation:

- [Terraform Documentation](https://www.terraform.io/docs/index.html)
- [Google Cloud Platform Documentation](https://cloud.google.com/docs)
- [Google Cloud DNS Documentation](https://cloud.google.com/dns/docs)
