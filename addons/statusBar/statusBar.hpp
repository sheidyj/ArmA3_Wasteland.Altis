class RscWastelandStatusBar
{
        idd = -1;
		duration = 10e10;
        onLoad = "uiNamespace setVariable ['RscWastelandStatusBar', _this select 0];";
		fadein = 0;
		fadeout = 0;
		movingEnable = 0;
		objects[] = {};

      class controlsBackground
      {
              class statusBarImage
              {
                      idc = 55557;
                      type = 0;
                      style = 48;
                      x = safezoneX + safezoneW - 0.913;
                      y = safezoneY + safezoneH - 0.077; //0.068
                      w = 1.35;
                      h = 0.08; //0.06
                      colorText[] = {1, 1, 1, 1};
                      colorBackground[]={0,0,0,0};
                      sizeEx = 0.4;
                      font = "PuristaSemibold";
                      text = "addons\statusbar\StatusBarBackground.paa";
              };
      };

        class controls
        {
                class statusBarText
                {
                        idc = 55554;
                        x = safezoneX + safezoneW - /*1.08*/1.2/*0*/3;
                        y = safezoneY + safezoneH - 0.060;
                        w = 0.50;
                        h = 0.06;
                        shadow = 2;
                        font = "PuristaSemibold";
                        size = 0.035;
                        type = 13;
						            style = 2;
                        text = "";

                        class Attributes
                        {
                                align="center";
                                color = "#ffffff";
                                font = "PuristaSemibold";
                        };
                };
        };
};
