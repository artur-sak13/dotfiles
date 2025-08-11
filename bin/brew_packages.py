import subprocess
import csv

def get_installed_packages():
    # Run the 'brew list' command with '--versions' to get installed packages with versions
    result = subprocess.run(['brew', 'list', '--versions'], stdout=subprocess.PIPE)
    packages = result.stdout.decode('utf-8').strip().split('\n')

    # Parse package name and version
    package_list = []
    for package in packages:
        parts = package.split()
        if len(parts) >= 2:
            package_name = parts[0]
            package_version = parts[1]
            package_list.append((package_name, package_version))

    return package_list

def get_package_info(package_name):
    # Run 'brew info' command to get the package description
    result = subprocess.run(['brew', 'info', package_name], stdout=subprocess.PIPE)
    info = result.stdout.decode('utf-8').strip()

    # Extract the description, typically the first line after the name
    description = info.split('\n')[1].strip() if len(info.split('\n')) > 1 else "No description available"

    return description

def write_to_csv(package_list, filename='brew_packages.csv'):
    # Write the package information to a CSV file
    with open(filename, 'w', newline='') as csvfile:
        fieldnames = ['Package Name', 'Version', 'Description']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

        writer.writeheader()
        for package_name, package_version in package_list:
            description = get_package_info(package_name)
            writer.writerow({
                'Package Name': package_name,
                'Version': package_version,
                'Description': description
            })

    print(f"CSV file '{filename}' created successfully.")

if __name__ == "__main__":
    packages = get_installed_packages()
    write_to_csv(packages)
