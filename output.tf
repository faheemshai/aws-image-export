output "image_name" {
  value       = "${data.local_file.image-name.content}"
  description = "image file name."
}