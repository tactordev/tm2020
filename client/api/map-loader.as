array<array<string>> MAP_PACKS = {
    {"7341", "Current Campaign"},
    {"293000", "All Campaigns"},
    {"293001", "RMC Map Pack"},
    {"", "Custom (single map)"},
    {"", "Custom (club campaign)"},
    {"", "Specific map (by TMX Id)"}
};
string selectedMapPackId = MAP_PACKS[0][0];


namespace MapLoader
{
    void LoadTestingMap()
    {
        startnew(LoadMap);
        return;
    }

    void LoadMap()
    {
        const int mapId = MapLoader::GetRandomMapFromPack();
        if (mapId == -1) {
            return;
        }
        const string url = "https://trackmania.exchange/maps/download/" + mapId;
        const string mode = "TrackMania/TM_PlayMap_Local";
        const string settingsXml = "<maniaplanet><map><mode>Local Play</mode></map></maniaplanet>";
        auto app = cast<CGameManiaPlanet>(GetApp());
        app.BackToMainMenu();
        while (!app.ManiaTitleControlScriptAPI.IsReady) yield();
        while (app.Switcher.ModuleStack.Length < 1 || cast<CTrackManiaMenus>(app.Switcher.ModuleStack[0]) is null) yield();
        yield();
        app.ManiaTitleControlScriptAPI.PlayMap(url, mode, settingsXml);
        return;
    }


    int GetRandomMapFromPack()
    {
        // api: /api/mappack/get_mappack_tracks/{id}
        // Get Mappack tracks
    
        if (selectedMapPackId == "") {
            Toasts::Warn("Custom map pack not implemented yet");
            return -1;
        }

        auto req = Net::HttpGet("https://trackmania.exchange/api/mappack/get_mappack_tracks/" + selectedMapPackId);
        while (!req.Finished()) {
            yield();
        }

        if (req.ResponseCode() != 200) {
            Toasts::Warn("Failed to get mappack tracks: " + req.ResponseCode());
            return -1;
        }


        auto json = Json::Parse(req.String());
        if (json is null) {
            Toasts::Warn("Failed to parse mappack tracks response");
            return -1;
        }

        auto tracks = json.Get("results");
        if (tracks is null || tracks.Length == 0) {
            Toasts::Warn("No tracks found in mappack");
            return -1;
        }
        

        int randomIndex = Math::Floor(Math::Rand(0, tracks.Length - 1));
        int trackId = tracks[randomIndex].Get("TrackID");

        return trackId;


    }
}