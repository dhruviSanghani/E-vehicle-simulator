using System.ComponentModel.DataAnnotations;

namespace E_vehicle_simulator.Models
{
    public class UsersModel
    {
        public int UserId { get; set; }
        [Required]
        [StringLength(45)]
        public string UserName { get; set; }
        public int UserTypeId { get; set; }
        [Required]
        [StringLength(100)]
        public string FullName { get; set; }
        [StringLength(20)]
        public string? Phone { get; set; }
        [StringLength(100)]
        public string? Email { get; set; }
    }
}
