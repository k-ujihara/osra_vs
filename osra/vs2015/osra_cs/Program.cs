using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

public static class OsraAPI
{
    [DllImport("libosra.dll", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
    public static extern int OsraProcessImage(
        string ptr_input_file,
        string ptr_output_file,
        int rotate,
        bool invert,
        int input_resolution,
        double threshold,
        int do_unpaper,
        bool jaggy,
        bool adaptive_option,
        string ptr_output_format,
        string ptr_embedded_format,
        bool show_confidence,
        bool show_resolution_guess,
        bool show_page,
        bool show_coordinates,
        bool show_avg_bond_length,
        bool show_learning,
        string ptr_osra_dir,
        string ptr_spelling_file,
        string ptr_superatom_file,
        bool debug,
        bool verbose,
        string ptr_output_image_file_prefix,
        string ptr_resize,
        string ptr_preview
    );
}

namespace osra_cs
{
    class Program
    {
        static void Main(string[] args)
        {
            var ret = OsraAPI.OsraProcessImage(
                @"test.png",
                @"a.sdf",
                0, false, 0, 0, 0, false, false,
                "sdf", "", false, false, false, false, false, false, "", "", "", false, false, "", "", "");
        }
    }
}
