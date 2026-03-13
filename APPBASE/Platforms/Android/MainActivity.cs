using Android.App;
using Android.Content.PM;
using Android.OS;
using Plugin.Fingerprint;

namespace APPBASE;

[Activity(Theme = "@style/Maui.MainTheme.NoActionBar", MainLauncher = true,
ConfigurationChanges = ConfigChanges.ScreenSize | ConfigChanges.Orientation |
ConfigChanges.UiMode | ConfigChanges.ScreenLayout |
ConfigChanges.SmallestScreenSize | ConfigChanges.Density)]


public class MainActivity : MauiAppCompatActivity
{
    protected override void OnCreate(Bundle savedInstanceState)
    {
        base.OnCreate(savedInstanceState);

        CrossFingerprint.SetCurrentActivityResolver(() => this);
    }
}