from device import DeviceManager
import ui

def main():
    print("Small Steps OS v0.2 Starting...")
    
    # 1. Init Hardware
    device = DeviceManager()
    device.vibrate(100)
    
    # 2. Init App
    app = ui.App(device)
    
    # 3. Register Pages
    app.register_page("menu", ui.MenuPage)
    app.register_page("focus", ui.FocusPage)
    app.register_page("list", ui.ListPage)
    app.register_page("story", ui.StoryPage)
    app.register_page("voice_hole", ui.VoiceHolePage)
    
    # 4. Start
    app.switch_to("menu")
    
    try:
        app.run()
    except KeyboardInterrupt:
        print("Stopped by User")
    except Exception as e:
        print(f"Crash: {e}")
        # Error handling/Logging could go here
        
if __name__ == "__main__":
    main()