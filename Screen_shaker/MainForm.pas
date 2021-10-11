{
        12.06.2004
      ______          _        __      _  _____                  _
     /  _   \ ___   / /____   / /_   (_)/ ___  \ ____   ____   / /
     / /  / // _ \ / // __ \ / __ \ / // /   |_|/ __ \ / __ \ / /
   _/ /_ / //  __ / // /_/ // / / // // /_____ / /_/ // /_/ // /
  /______ / \___//_// ____//_/ /_//_/ \______/ \____/ \____//_/
                   /_/http://delphicool.developpez.com
}
unit MainForm;

 interface


 uses    
   ShellApi, Messages, Windows,
   SysUtils, Classes, Controls, Forms, StdCtrls, Graphics, ExtCtrls ;

 type
   TMain = class(TForm)
    Logo: TImage;
    Moi: TLabel;
    Timer1: TTimer;
    procedure LogoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);


   private
   public
   end;


 const
   MonSite = 'http://delphicool.developpez.com';

 var
   Main: TMain;
   Fond :TBitMap;

 implementation

 {$R *.dfm}
 {$R res.res}      

procedure TMain.LogoClick(Sender: TObject);
begin
 ShellExecute(handle, nil, PChar(MonSite), nil, nil,sw_maximize);
end;

Procedure CaptureEcran(Bmp :TBitMap);
var
 c :TCanvas;
 r :TRect;
begin
   c := TCanvas.Create;
   c.Handle := GetWindowDC (GetDesktopWindow);
     try
      r := Rect(0,0,screen.width,screen.height);
      Bmp.Width := screen.Width;
      Bmp.Height := screen.Height;
      Bmp.Canvas.CopyRect(r, c, r);
     finally
      ReleaseDC(0, c.handle);
      c.Free;
     end;
end;         

procedure TMain.FormCreate(Sender: TObject);
begin
// on créer le bitmap
   Fond := TBitMap.Create;
// on met notre capture dans celui ci
   CaptureEcran(Fond);
//on met le bitmap en fond de fenêtre
   Main.Brush.Bitmap := Fond;
//on met la fenêtre en position TOUJOURS AU DESSUS (fsStayOnTop est pas terrible)
   SetWindowPos(main.handle, HWND_TOPMOST, 0,0,width, height,SWP_NOMOVE);

// on active le timer
   Timer1.Enabled := True;
end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
  begin
// on libere le bitmap
   Fond.Free;
  end;

procedure TMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  begin
// si on press [ESC] on quitte  
   if key = 27 then close;
  end;

procedure TMain.Timer1Timer(Sender: TObject);
 var x, y:integer;
  begin
// on donne des valeurs aléatoire à x et y, max 5
   randomize;
   x := random(5);
   y := random(5);

// on repositione la fenêtre
   left := x;
   top := y;
  end;

end.

