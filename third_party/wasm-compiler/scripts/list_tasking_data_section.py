import os
import subprocess

# Function to find .o files


def find_o_files(directory):
    paths = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith(".o"):
                paths.append(os.path.join(root, file))
    return paths


# Function to execute the hldumptc command and capture the output


def run_hldumptc(file_paths):
    output_lines = []
    for file_path in file_paths:
        try:
            # Run the hldumptc command
            result = subprocess.run(
                ["hldumptc", "-FCDFHMNsY", file_path],
                capture_output=True,
                text=True,
                check=True,
            )
            # Filter output to only include 'data' sections
            data_lines = [
                line for line in result.stdout.splitlines() if " data " in line
            ]
            data_output = "\n".join(data_lines)
            # Append the filtered output to the output_lines list
            output_lines.append(f"{file_path}:\n{data_output}")
            output_lines.append("-" * 60)
        except subprocess.CalledProcessError as e:
            output_lines.append(
                f"Error occurred while processing {file_path}: {e.stderr}"
            )
    return "\n".join(output_lines)


# Main function to orchestrate the operations
if __name__ == "__main__":
    # Replace this path with the one you want to use
    search_dir = r".\bazel-out\x64_windows-fastbuild\bin\src\_objs"

    # Find all .o files
    o_files = find_o_files(search_dir)

    # Run hldumptc on each .o file and collect outputs
    output_content = run_hldumptc(o_files)

    # Write to the output file
    with open("hldumptc_output.txt", "w") as file:
        file.write(output_content)

    print("Process complete. Check 'hldumptc_output.txt' for the output.")
