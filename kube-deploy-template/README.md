# Kubernetes Workload Deployment Template

A template repository for deploying applications to Kubernetes clusters.

## Features

- Sample Kubernetes manifests in `components/`, `crd/`, and `resource/`
- Example site or documentation files in `site/`
- Helm chart integration (optional)
- CI/CD pipeline suggestions

## Getting Started

1. **Clone this repository:**

    ```shell
    git clone https://github.com/your-org/kube-deploy-template.git
    cd kube-deploy-template
    ```

2. **Customize manifests:**

    - Edit files in the `components/`, `crd/`, and `resource/` directories to match your application's requirements.
    - You can add or modify Kubernetes resources as needed.

3. **Deploy to your cluster:**

    <!-- TODO: deploy -->

## Directory Structure

```text
.
├── components/      # Application components
├── crd/             # Custom Resource Definitions
├── resource/        # Additional Kubernetes resources
├── site/            # Site or documentation files
└── README.md        # Project documentation
```

## Requirements

- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- Access to a Kubernetes cluster

## License

Copyright (c) 2025 Schubert Anselme <schubert@anselm.es>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <https://www.gnu.org/licenses/>.
