from PIL import Image

def get_pixel_color(image, position):
    # Get the color of the pixel at the specified position
    return image.getpixel(position)

def main():
    # Load the main image and the template using Pillow
    main_image_path = 'path/to/main/image.jpg'
    template_path = 'path/to/template/image.jpg'
    main_image = Image.open(main_image_path)
    template = Image.open(template_path)

    # Get the color of the top-left pixel in the template
    template_color = get_pixel_color(template, (0, 0))
    print(f'Template Color: {template_color}')

    # Assume you have a specific template location (x, y)
    template_location = (100, 150)
    
    # Get the color of the specified location in the main image
    main_image_color = get_pixel_color(main_image, template_location)
    print(f'Main Image Color at Template Location: {main_image_color}')

if __name__ == "__main__":
    main()


# Example usage
# main_image_path = 'path/to/main/image.jpg'
# template_path = 'path/to/template/image.jpg'
    max_template_size = 50  # Maximum template size to consider
# match_background_color(main_image_path, template_path, max_template_size)


    # Example usage
    main_image_path = r'C:\Users\RakeshSripelli\Downloads\MicrosoftTeams-imag.png'
    template_path = r'C:\Users\RakeshSripelli\Downloads\MicrosoftTeams-im.png'
    # template_position = (100, 150)  # Example template location (x, y)
    # template_size = (50, 50)  # Example template size (width, height)
    match_background_color(main_image_path, template_path, max_template_size)




# # Example usage
# main_image_path = r'C:\Users\RakeshSripelli\Downloads\MicrosoftTeams-ima.png'
# template_path = r'C:\Users\RakeshSripelli\Downloads\MicrosoftTeams-im.png'
# check_background_color(main_image_path, template_path)
 
 
# main_image_path = 'D:\\Cluster_Rtos_Framework\\RTOS_FRAMEWORK\\config\\matched_image.png'
# template_path = 'D:\\Cluster_Rtos_Framework\\RTOS_FRAMEWORK\\config\\same_temp.png'
# output_image_path = 'D:\\Cluster_Rtos_Framework\\RTOS_FRAMEWORK\\config\\matched_image11.png'
# print(datetime.datetime.now())
# result = match_template(main_image_path, template_path, output_image_path)
# print(datetime.datetime.now())

# main_image_path = r'C:\Users\RakeshSripelli\Downloads\aa.png'
# template_path = r'C:\Users\RakeshSripelli\Downloads\aa.png'
# output_image_path = r'C:\Users\RakeshSripelli\Downloads\Micr.png'
# start = datetime.datetime.now()
# result=match_template(main_image_path, template_path, output_image_path)
# end = datetime.datetime.now()
# print(start,end)