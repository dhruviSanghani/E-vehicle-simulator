using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;

namespace E_vehicle_simulator.Models
{    
    public class EvCarModel
    {
        [Key]
        public int CarId { get; set; }
        [Required]
        public string CarModelName { get; set; }
        [Required]
        public string CarModelNo { get; set; }
        [Required]
        public string CarCompany { get; set; }
        [Required]
        public Double MaxCharge { get; set; }
        [Required]
        public int EvBrandID { get; set; }
        [JsonIgnore]
        public string? EVBrandName { get; set; }
        [Required]
        public int ChargingTypeID { get; set; }
        [JsonIgnore]
        public string? ChargingType { get; set; }
        public string EnergyConsumption { get; set; }
        public string ChargingCurve { get; set; }
        
        public int HasAutoPilot
        {
            get
            {
                if (IsAutoPilot == true)
                {
                    return 1;
                }
                else { return 0; }
            }
            set
            {
                if (value == 1)
                {
                    IsAutoPilot = true;
                }
                else
                {
                    //DEFAULT Value. 
                    IsAutoPilot = false;
                }
            }
        }
        public int AutoShift
        {
            get
            {
                if (IsAutoShift == true)
                {
                    return 1;
                }
                else { return 0; }
            }
            set
            {
                if (value == 1)
                {
                    IsAutoShift = true;
                }
                else
                {
                    //DEFAULT Value. 
                    IsAutoShift = false;
                }
            }
        }
        [JsonIgnore]
        public bool IsAutoPilot { get; set; }
        
        [JsonIgnore]
        public bool IsAutoShift { get; set; }
        
        public string PeakPower { get; set; }
    }
}
