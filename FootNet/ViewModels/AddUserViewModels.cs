using System.ComponentModel.DataAnnotations;


namespace FootNet.ViewModels
{

    public class AddUserViewModels
    {

        [Required]
        public string? Username { get; set; }

        [EmailAddress]
        [Required(ErrorMessage = "Vui lòng nhập Email")]
        [RegularExpression("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$", ErrorMessage = "Email của bạn sai định dạng")]
        public string? Email { get; set; }

        [Required]
        [RegularExpression("^(?=.*[A-Z])(?=.*[!@#$%^&*])(?=.*[0-9]).{8,}$", ErrorMessage = "Mật khẩu phải chứa ít nhất một chữ hoa, một ký tự đặc biệt và một số.")]

        [DataType(DataType.Password)]
        public string? Password { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [Compare("Password", ErrorMessage = "Mật khẩu không khớp vui lòng nhập lại")]
        public string? Verify { get; set; }
    }
}
