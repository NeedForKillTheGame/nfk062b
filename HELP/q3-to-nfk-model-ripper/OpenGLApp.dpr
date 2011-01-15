//------------------------------------------------------------------------
//
// Author      : Jan Horn. Rest In Peace friend...
// Email       : jhorn@global.co.za
// Website     : http://home.global.co.za/~jhorn
// Date        : 7 October 2001
// Version     : 1.0
// Description : Quake 3 Model Loader (MD3 Loader)
//
//------------------------------------------------------------------------
program OpenGLApp;

uses
  Windows,
  Messages,
  OpenGL,
  model,
  Textures,
  SysUtils;

const
  WND_TITLE = 'RIPPA. original code by Jan Horn. adapted for NFK by 3d[Power]';
  FPS_TIMER = 1;                     // Timer to calculate FPS
  FPS_INTERVAL = 1000;               // Calculate FPS every 1000 ms
  VAITKEY:boolean=true;
  ANIMUP:boolean=true;  // animate upper.

var
  h_Wnd  : HWND;                     // Global window handle
  h_DC   : HDC;                      // Global device context
  h_RC   : HGLRC;                    // OpenGL rendering context
  keys : Array[0..255] of Boolean;   // Holds keystrokes
  FPSCount : Integer = 0;            // Counter for FPS
  ElapsedTime : Integer;             // Elapsed time between frames
  clr:byte;
  waitz: byte;

  // User vaiables
  YRot, XRot     : glFloat;    // Y Rotation
  Depth  : glFloat;
  Xcoord, Ycoord, Zcoord : Integer;
  MouseButton : Integer;

  WireFrame  : Boolean;
  ShowFrames : Boolean;
  fontBase : GLuint;                // base to the font display lists

  Player : Q3Player;
  Weapon : TMD3Model;

{$R *.RES}

procedure glBindTexture(target: GLenum; texture: GLuint); stdcall; external opengl32;

{------------------------------------------------------------------}
{  Function to convert int to string. (No sysutils = smaller EXE)  }
{------------------------------------------------------------------}
function IntToStr(Num : Integer) : String;  // using SysUtils increase file size by 100K
begin
  Str(Num, result);
end;


{----------------------------------------------------------------}
{  Procedures used to create and write text                      }
{----------------------------------------------------------------}
procedure BuildFont;
var font : HFONT;
begin
  fontBase := glGenLists(96);                       // Generate enough display lists to hold
  font := CreateFont(-16,                           // height of font
		     0,                             // average character width
		     0,                             // angle of escapement
		     0,                             // base-line orientation angle
		     FW_BOLD,                       // font weight
		     0,			            // italic
		     0,                             // underline
		     0,			            // strikeout
		     ANSI_CHARSET,                  // character set
		     OUT_TT_PRECIS,	            // output precision
		     CLIP_DEFAULT_PRECIS,           // clipping precision
		     ANTIALIASED_QUALITY,           // output quality
		     FF_DONTCARE or DEFAULT_PITCH,  // pitch and family
		     'Arial');                      // font
  SelectObject(h_DC, font);                   // Sets the new font as the current font in the device context
  wglUseFontBitmaps(h_DC, 32, 96, fontBase);  // Creates a set display lists containing the bitmap fonts
end;

procedure KillFont;
begin
  glDeleteLists(fontBase, 96);                // Delete the font display lists, returning used memory
end;

procedure glWrite(X, Y : GLUint; text : PChar);
var drawRect : TRect;
begin
  glPushAttrib(GL_DEPTH_TEST);  // Save the current Depth test settings (Used for blending )
  glDisable(GL_DEPTH_TEST);     // Turn off depth testing (otherwise we get no FPS)
  glDisable(GL_TEXTURE_2D);     // Turn off textures, don't want our text textured
  glMatrixMode(GL_PROJECTION);  // Switch to the projection matrix
  glPushMatrix();               // Save current projection matrix
  glLoadIdentity();

  GetWindowRect(GetDesktopWindow(), drawRect);  // Get current window size
  glOrtho(0, drawRect.right, 0, drawRect.bottom, -1, 1);  // Change the projection matrix using an orthgraphic projection
  glMatrixMode(GL_MODELVIEW);  // Return to the modelview matrix
  glPushMatrix();              // Save the current modelview matrix
  glLoadIdentity();
  glColor3f(1.0, 1.0, 1.0);    // Text color

  glRasterPos2i(X, Y);                                // Position the Text
  glPushAttrib(GL_LIST_BIT);                          // Save's the current base list
  glListBase(fontBase - 32);                              // Set the base list to our character list
  glCallLists(length(text), GL_UNSIGNED_BYTE, PChar(text));  // Display the text
  glPopAttrib();                                      // Restore the old base list

  glMatrixMode(GL_PROJECTION);  // Switch to projection matrix
  glPopMatrix();                // Restore the old projection matrix
  glMatrixMode(GL_MODELVIEW);   // Return to modelview matrix
  glPopMatrix();                // Restore old modelview matrix
  glEnable(GL_TEXTURE_2D);      // Turn on textures, don't want our text textured
  glPopAttrib();                // Restore depth testing
end;


{------------------------------------------------------------------}
{  Function used to write out the current upper and lower frames   }
{------------------------------------------------------------------}
procedure DrawCurrentFrames;
begin
  case Player.animLower of
    BOTH_DEATH1 : glWrite(15, 500, 'Lower : Death 1');
    BOTH_DEAD1  : glWrite(15, 500, 'Lower : Dead 1');
    BOTH_DEATH2 : glWrite(15, 500, 'Lower : Death 2');
    BOTH_DEAD2  : glWrite(15, 500, 'Lower : Dead 2');
    BOTH_DEATH3 : glWrite(15, 500, 'Lower : Death 3');
    BOTH_DEAD3  : glWrite(15, 500, 'Lower : Dead 3');

    LEGS_WALKCR : glWrite(15, 500, 'Lower : Walk Crouch');
    LEGS_WALK   : glWrite(15, 500, 'Lower : Walk');
    LEGS_RUN    : glWrite(15, 500, 'Lower : Run');
    LEGS_BACK   : glWrite(15, 500, 'Lower : Backwarks');
    LEGS_SWIM   : glWrite(15, 500, 'Lower : Swim');
    LEGS_JUMP   : glWrite(15, 500, 'Lower : Jump');
    LEGS_LAND   : glWrite(15, 500, 'Lower : Land');
    LEGS_JUMPB  : glWrite(15, 500, 'Lower : Jump Backwards');
    LEGS_LANDB  : glWrite(15, 500, 'Lower : Land Backwards');
    LEGS_IDLE   : glWrite(15, 500, 'Lower : Idle');
    LEGS_IDLECR : glWrite(15, 500, 'Lower : Idel Crouch');
    LEGS_TURN   : glWrite(15, 500, 'Lower : Turn');
  end;

  case Player.animUpper of
    BOTH_DEATH1 : glWrite(600, 500, 'Upper : Death 1');
    BOTH_DEAD1  : glWrite(600, 500, 'Upper : Dead 1');
    BOTH_DEATH2 : glWrite(600, 500, 'Upper : Death 2');
    BOTH_DEAD2  : glWrite(600, 500, 'Upper : Dead 2');
    BOTH_DEATH3 : glWrite(600, 500, 'Upper : Death 3');
    BOTH_DEAD3  : glWrite(600, 500, 'Upper : Dead 3');

    TORSO_GESTURE : glWrite(600, 500, 'Upper : Gesture');
    TORSO_ATTACK  : glWrite(600, 500, 'Upper : Attack');
    TORSO_ATTACK2 : glWrite(600, 500, 'Upper : Attack2');
    TORSO_DROP    : glWrite(600, 500, 'Upper : Drop');
    TORSO_RAISE   : glWrite(600, 500, 'Upper : Raise');
    TORSO_STAND   : glWrite(600, 500, 'Upper : Stand');
    LEGS_LAND     : glWrite(600, 500, 'Upper : Land');
    TORSO_STAND2  : glWrite(600, 500, 'Upper : Stand2');
  end;
end;


{------------------------------------------------------------------}
{  Function used to load a railgin and join it to the player       }
{------------------------------------------------------------------}
procedure LoadRailgun;

  procedure LoadMeshTexture(const imagename, meshname : String);
  var I : Integer;
  begin
    // Find the right mesh item to assign the skin to
    for I :=0 to Weapon.header.numMeshes-1 do
    begin
      // check it the two names are the same
      if UpperCase(CharArrToStr(Weapon.meshes[i].MeshHeader.Name)) = Uppercase(meshname) then
      begin
        LoadTexture(ImageName, Weapon.meshes[i].Texture, FALSE);
        Weapon.meshes[i].SetTexture :=TRUE;
      end;
    end;
  end;

begin
//  Weapon.LoadModel('model\railgun\railgun.md3');
//
{  LoadMeshTexture('model\railgun\railgun1.jpg',      'w_railgun1');
  LoadMeshTexture('model\railgun\railgun2.glow.jpg', 'w_railgun2');
  LoadMeshTexture('model\railgun\railgun4.jpg',      'w_railgun4');
  LoadMeshTexture('model\railgun\railgun3.glow.jpg', 'w_railgun3');
  LoadMeshTexture('model\railgun\railgun1.jpg',      'w_railgun05');
}
//  Player.Upper.LinkModel('tag_weapon', Weapon);
end;


{------------------------------------------------------------------}
{  Function to draw the actual scene                               }
{------------------------------------------------------------------}
procedure glDraw();
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);    // Clear The Screen And The Depth Buffer
  glLoadIdentity();                                       // Reset The View

  glTranslatef(0.0, -10.0, Depth);

  glRotatef(xRot, 1, 0, 0);
  glRotatef(yRot, 0, 0, 1);

  glWrite(15, 430, pchar('yRot:'+inttostr(round(yrot))));

  glWrite(15, 400, pchar('xRot:'+inttostr(round(xrot))));

  glWrite(15, 460, pchar('Depth:'+inttostr(round(Depth))));

  glWrite(15, 490, pchar('clr:'+inttostr(round(clr))));
  glWrite(15, 300, pchar('lowerframe:'+inttostr(player.Lower.frame)));
  glWrite(15, 270, pchar('upperframe:'+inttostr(player.upper.frame)));
  glWrite(15, 230, pchar('Headframe:'+inttostr(player.Head.frame)));

  if ANIMUP then
  glWrite(15, 320, pchar('animup:y')) else
  glWrite(15, 320, pchar('animup:n'));

  if waitz>0 then dec(waitz);


//  if h_Wnd.

//  if VAITKEY=true then begin
  Player.Draw(0);
  //        VAITKEY := false;
    //      end;

  if ShowFrames then
    DrawCurrentFrames;
end;


{------------------------------------------------------------------}
{  Initialise OpenGL                                               }
{------------------------------------------------------------------}
procedure glInit();
var dir,skn :string;
begin
if clr=0 then
  glClearColor(0, 0, 0, 0) else
  glClearColor(1, 1, 1, 0);

  glShadeModel(GL_SMOOTH);                 // Enables Smooth Color Shading
  glClearDepth(1.0);                       // Depth Buffer Setup
  glEnable(GL_DEPTH_TEST);                 // Enable Depth Buffer
  glDepthFunc(GL_LESS);		           // The Type Of Depth Test To Do

  glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);   //Realy Nice perspective calculations

  glEnable(GL_TEXTURE_2D);                     // Enable Texture Mapping

  xRot :=-90;
  yRot :=0;
  Depth :=-100;

  ShowFrames :=TRUE;
  BuildFont();

  dir := 'model\';
  skn := 'default';
  if paramstr(1) <> '' then dir := dir + paramstr(1)+'\' else dir := dir+'sarge\';
  if paramstr(2) <> '' then skn := paramstr(2);
  if paramstr(3) <> '' then depth := strtoint(paramstr(3));

//  Player.LoadPlayer(dir, skn);
  Player.LoadPlayer(pchar(dir), pchar(skn));

  LoadRailgun;
end;


{------------------------------------------------------------------}
{  Handle window resize                                            }
{------------------------------------------------------------------}
procedure glResizeWnd(Width, Height : Integer);
begin
  if (Height = 0) then                // prevent divide by zero exception
    Height := 1;
  glViewport(0, 0, Width, Height);    // Set the viewport for the OpenGL window
  glMatrixMode(GL_PROJECTION);        // Change Matrix Mode to Projection
  glLoadIdentity();                   // Reset View
  gluPerspective(45.0, Width/Height, 1.0, 500.0);  // Do the perspective calculations. Last value = max clipping depth
  glMatrixMode(GL_MODELVIEW);         // Return to the modelview matrix
  glLoadIdentity();                   // Reset View
end;


{------------------------------------------------------------------}
{  Processes all the keystrokes                                    }
{------------------------------------------------------------------}
procedure ProcessKeys;
begin
  if keys[Ord('F')] then       // Show the current upper and lower frames
  begin
    ShowFrames :=Not(ShowFrames);
    keys[Ord('F')] :=FALSE;
  end;

  if keys[Ord('W')] then       // Enable and Disable wireframe mode
  begin
    WireFrame :=Not(WireFrame);
    if WireFrame then
    begin
      glDisable(GL_TEXTURE_2D);
      glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
    end
    else
    begin
      glEnable(GL_TEXTURE_2D);
      glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
    end;
    keys[Ord('W')] :=FALSE;
  end;


  if keys[Ord('Z')] then       // Go to next leg movement
  begin
    Inc(Player.animLower);
    if (Player.animLower > BOTH_DEAD3) AND (Player.animLower < LEGS_WALKCR) then
    begin
       Player.animLower := LEGS_WALKCR;
       Player.animUpper := TORSO_STAND;
       Player.SetAnim(Player.animUpper);
    end;
    if Player.animLower > LEGS_TURN then
       Player.animLower :=BOTH_DEATH1;
    Player.SetAnim(Player.animLower);
    keys[Ord('Z')] :=FALSE;
  end;

  if keys[Ord('X')] then      // go to previous leg movement
  begin
    Dec(Player.animLower);
    if (Player.animLower > BOTH_DEAD3) AND (Player.animLower < LEGS_WALKCR) then
       Player.animLower := BOTH_DEAD3;
    if Player.animLower < BOTH_DEATH1 then
       Player.animLower :=LEGS_TURN;
    Player.SetAnim(Player.animLower);
    keys[Ord('X')] :=FALSE;
  end;

  if keys[Ord('A')] then      // go to next torso movement
  begin
    Inc(Player.animUpper);
    if Player.animUpper > TORSO_STAND2 then
       Player.animUpper :=TORSO_GESTURE;
    Player.SetAnim(Player.animUpper);
    keys[Ord('A')] :=FALSE;
  end;

  if keys[Ord('I')] then depth:=depth+1;
  if keys[Ord('K')] then depth:=depth-1;

  if (keys[VK_SPACE]) and (waitz=0) then      // Reset Position to default
  begin
        waitz:=25;
//        player.singleupdate(0);
        player.Lower.UpdateFrame(time);
        if ANIMUP then player.Upper.UpdateFrame(time);
        player.Head.UpdateFrame(time);

  end;

  if keys[Ord('O')] then begin
        if CLR=1 then CLR:=0 else CLR:=1;
        if clr=0 then
          glClearColor(0, 0, 0, 0) else
          glClearColor(1, 1, 1, 0);
        end;

  if keys[Ord('Y')] then glResizeWnd(400, 300);


  if keys[Ord('S')] then      // go to previous torso movement
  begin
    Dec(Player.animUpper);
    if Player.animUpper < TORSO_GESTURE then
       Player.animUpper :=TORSO_STAND2;
    Player.SetAnim(Player.animUpper);
    keys[Ord('S')] :=FALSE;
  end;

  if keys[Ord('1')] then ANIMUP:=NOT ANIMUP;     // go to previous torso movement

end;


{------------------------------------------------------------------}
{  Determines the application’s response to the messages received  }
{------------------------------------------------------------------}
function WndProc(hWnd: HWND; Msg: UINT;  wParam: WPARAM;  lParam: LPARAM): LRESULT; stdcall;
begin
  case (Msg) of
    WM_CREATE:
      begin
        // Insert stuff you want executed when the program starts
      end;
    WM_CLOSE:
      begin
        PostQuitMessage(0);
        Result := 0
      end;
    WM_KEYDOWN:       // Set the pressed key (wparam) to equal true so we can check if its pressed
      begin
        keys[wParam] := True;
        Result := 0;
      end;
    WM_KEYUP:         // Set the released key (wparam) to equal false so we can check if its pressed
      begin
        keys[wParam] := False;
        Result := 0;
      end;
    WM_SIZE:          // Resize the window with the new width and height
      begin
        glResizeWnd(LOWORD(lParam),HIWORD(lParam));
        Result := 0;
      end;

    // Mouse buttons
    WM_LBUTTONDOWN:
      begin
        ReleaseCapture();   // need them here, because if mouse moves off
        SetCapture(h_Wnd);  // window and returns, it needs to reset status
        MouseButton := 1;
        Xcoord := LOWORD(lParam);
        Ycoord := HIWORD(lParam);
        Result := 0;
      end;
    WM_LBUTTONUP:
      begin
        ReleaseCapture();   // above
        MouseButton := 0;
        XCoord := 0;
        YCoord := 0;
        Result := 0;
      end;
    WM_RBUTTONDOWN:
      begin
        ReleaseCapture();   // need them here, because if mouse moves off
        SetCapture(h_Wnd);  // window and returns, it needs to reset status
        MouseButton := 2;
        ZCoord :=HIWORD(lParam);
        Result := 0;
      end;
    WM_RBUTTONUP:
      begin
        ReleaseCapture();   // above
        MouseButton := 0;
        Result := 0;
      end;
    WM_MOUSEMOVE:
      begin
        if MouseButton = 1 then
        begin
          xRot := xRot + (HIWORD(lParam) - Ycoord)/2;  // moving up and down = rot around X-axis
          yRot := yRot + (LOWORD(lParam) - Xcoord)/2;
          Xcoord := LOWORD(lParam);
          Ycoord := HIWORD(lParam);
        end;
        if MouseButton = 2 then
        begin
          Depth :=Depth - (HIWORD(lParam)-ZCoord)/10;
          Zcoord := HIWORD(lParam);
        end;
        Result := 0;
      end;
    WM_TIMER :                     // Add code here for all timers to be used.
      begin
        if wParam = FPS_TIMER then
        begin
          FPSCount :=Round(FPSCount * 1000/FPS_INTERVAL);   // calculate to get per Second incase intercal is less or greater than 1 second
          SetWindowText(h_Wnd, PChar(WND_TITLE + '   [' + intToStr(FPSCount) + ' FPS]'));
          FPSCount := 0;
          Result := 0;
        end;
      end;
    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam);    // Default result if nothing happens
  end;
end;


{---------------------------------------------------------------------}
{  Properly destroys the window created at startup (no memory leaks)  }
{---------------------------------------------------------------------}
procedure glKillWnd(Fullscreen : Boolean);
begin
  if Fullscreen then             // Change back to non fullscreen
  begin
    ChangeDisplaySettings(devmode(nil^), 0);
    ShowCursor(True);
  end;

  // Makes current rendering context not current, and releases the device
  // context that is used by the rendering context.
  if (not wglMakeCurrent(h_DC, 0)) then
    MessageBox(0, 'Release of DC and RC failed!', 'Error', MB_OK or MB_ICONERROR);

  // Attempts to delete the rendering context
  if (not wglDeleteContext(h_RC)) then
  begin
    MessageBox(0, 'Release of rendering context failed!', 'Error', MB_OK or MB_ICONERROR);
    h_RC := 0;
  end;

  // Attemps to release the device context
  if ((h_DC = 1) and (ReleaseDC(h_Wnd, h_DC) <> 0)) then
  begin
    MessageBox(0, 'Release of device context failed!', 'Error', MB_OK or MB_ICONERROR);
    h_DC := 0;
  end;

  // Attempts to destroy the window
  if ((h_Wnd <> 0) and (not DestroyWindow(h_Wnd))) then
  begin
    MessageBox(0, 'Unable to destroy window!', 'Error', MB_OK or MB_ICONERROR);
    h_Wnd := 0;
  end;

  // Attempts to unregister the window class
  if (not UnRegisterClass('OpenGL', hInstance)) then
  begin
    MessageBox(0, 'Unable to unregister window class!', 'Error', MB_OK or MB_ICONERROR);
    hInstance := 0;
  end;
end;


{--------------------------------------------------------------------}
{  Creates the window and attaches a OpenGL rendering context to it  }
{--------------------------------------------------------------------}
function glCreateWnd(Width, Height : Integer; Fullscreen : Boolean; PixelDepth : Integer) : Boolean;
var
  wndClass : TWndClass;         // Window class
  dwStyle : DWORD;              // Window styles
  dwExStyle : DWORD;            // Extended window styles
  dmScreenSettings : DEVMODE;   // Screen settings (fullscreen, etc...)
  PixelFormat : GLuint;         // Settings for the OpenGL rendering
  h_Instance : HINST;           // Current instance
  pfd : TPIXELFORMATDESCRIPTOR;  // Settings for the OpenGL window
begin
  h_Instance := GetModuleHandle(nil);       //Grab An Instance For Our Window
  ZeroMemory(@wndClass, SizeOf(wndClass));  // Clear the window class structure

  with wndClass do                    // Set up the window class
  begin
    style         := CS_HREDRAW or    // Redraws entire window if length changes
                     CS_VREDRAW or    // Redraws entire window if height changes
                     CS_OWNDC;        // Unique device context for the window
    lpfnWndProc   := @WndProc;        // Set the window procedure to our func WndProc
    hInstance     := h_Instance;
    hCursor       := LoadCursor(0, IDC_ARROW);
    lpszClassName := 'OpenGL';
  end;

  if (RegisterClass(wndClass) = 0) then  // Attemp to register the window class
  begin
    MessageBox(0, 'Failed to register the window class!', 'Error', MB_OK or MB_ICONERROR);
    Result := False;
    Exit
  end;

  // Change to fullscreen if so desired
  if Fullscreen then
  begin
    ZeroMemory(@dmScreenSettings, SizeOf(dmScreenSettings));
    with dmScreenSettings do begin              // Set parameters for the screen setting
      dmSize       := SizeOf(dmScreenSettings);
      dmPelsWidth  := Width;                    // Window width
      dmPelsHeight := Height;                   // Window height
      dmBitsPerPel := PixelDepth;               // Window color depth
      dmFields     := DM_PELSWIDTH or DM_PELSHEIGHT or DM_BITSPERPEL;
    end;

    // Try to change screen mode to fullscreen
    if (ChangeDisplaySettings(dmScreenSettings, CDS_FULLSCREEN) = DISP_CHANGE_FAILED) then
    begin
      MessageBox(0, 'Unable to switch to fullscreen!', 'Error', MB_OK or MB_ICONERROR);
      Fullscreen := False;
    end;
  end;

  // If we are still in fullscreen then
  if (Fullscreen) then
  begin
    dwStyle := WS_POPUP or                // Creates a popup window
               WS_CLIPCHILDREN            // Doesn't draw within child windows
               or WS_CLIPSIBLINGS;        // Doesn't draw within sibling windows
    dwExStyle := WS_EX_APPWINDOW;         // Top level window
    ShowCursor(False);                    // Turn of the cursor (gets in the way)
  end
  else
  begin
    dwStyle := WS_OVERLAPPEDWINDOW or     // Creates an overlapping window
               WS_CLIPCHILDREN or         // Doesn't draw within child windows
               WS_CLIPSIBLINGS;           // Doesn't draw within sibling windows
    dwExStyle := WS_EX_APPWINDOW or       // Top level window
                 WS_EX_CLIENTEDGE	;        // Border with a raised edge
  end;

  // Attempt to create the actual window
  h_Wnd := CreateWindowEx(dwExStyle,      // Extended window styles
                          'OpenGL',       // Class name
                          WND_TITLE,      // Window title (caption)
                          dwStyle,        // Window styles
                          0, 0,           // Window position
                          Width, Height,  // Size of window
                          0,              // No parent window
                          0,              // No menu
                          h_Instance,     // Instance
                          nil);           // Pass nothing to WM_CREATE
  if h_Wnd = 0 then
  begin
    glKillWnd(Fullscreen);                // Undo all the settings we've changed
    MessageBox(0, 'Unable to create window!', 'Error', MB_OK or MB_ICONERROR);
    Result := False;
    Exit;
  end;

  // Try to get a device context
  h_DC := GetDC(h_Wnd);
  if (h_DC = 0) then
  begin
    glKillWnd(Fullscreen);
    MessageBox(0, 'Unable to get a device context!', 'Error', MB_OK or MB_ICONERROR);
    Result := False;
    Exit;
  end;

  // Settings for the OpenGL window
  with pfd do
  begin
    nSize           := SizeOf(TPIXELFORMATDESCRIPTOR); // Size Of This Pixel Format Descriptor
    nVersion        := 1;                    // The version of this data structure
    dwFlags         := PFD_DRAW_TO_WINDOW    // Buffer supports drawing to window
                       or PFD_SUPPORT_OPENGL // Buffer supports OpenGL drawing
                       or PFD_DOUBLEBUFFER;  // Supports double buffering
    iPixelType      := PFD_TYPE_RGBA;        // RGBA color format
    cColorBits      := PixelDepth;           // OpenGL color depth
    cRedBits        := 0;                    // Number of red bitplanes
    cRedShift       := 0;                    // Shift count for red bitplanes
    cGreenBits      := 0;                    // Number of green bitplanes
    cGreenShift     := 0;                    // Shift count for green bitplanes
    cBlueBits       := 0;                    // Number of blue bitplanes
    cBlueShift      := 0;                    // Shift count for blue bitplanes
    cAlphaBits      := 0;                    // Not supported
    cAlphaShift     := 0;                    // Not supported
    cAccumBits      := 0;                    // No accumulation buffer
    cAccumRedBits   := 0;                    // Number of red bits in a-buffer
    cAccumGreenBits := 0;                    // Number of green bits in a-buffer
    cAccumBlueBits  := 0;                    // Number of blue bits in a-buffer
    cAccumAlphaBits := 0;                    // Number of alpha bits in a-buffer
    cDepthBits      := 16;                   // Specifies the depth of the depth buffer
    cStencilBits    := 0;                    // Turn off stencil buffer
    cAuxBuffers     := 0;                    // Not supported
    iLayerType      := PFD_MAIN_PLANE;       // Ignored
    bReserved       := 0;                    // Number of overlay and underlay planes
    dwLayerMask     := 0;                    // Ignored
    dwVisibleMask   := 0;                    // Transparent color of underlay plane
    dwDamageMask    := 0;                     // Ignored
  end;

  // Attempts to find the pixel format supported by a device context that is the best match to a given pixel format specification.
  PixelFormat := ChoosePixelFormat(h_DC, @pfd);
  if (PixelFormat = 0) then
  begin
    glKillWnd(Fullscreen);
    MessageBox(0, 'Unable to find a suitable pixel format', 'Error', MB_OK or MB_ICONERROR);
    Result := False;
    Exit;
  end;

  // Sets the specified device context's pixel format to the format specified by the PixelFormat.
  if (not SetPixelFormat(h_DC, PixelFormat, @pfd)) then
  begin
    glKillWnd(Fullscreen);
    MessageBox(0, 'Unable to set the pixel format', 'Error', MB_OK or MB_ICONERROR);
    Result := False;
    Exit;
  end;

  // Create a OpenGL rendering context
  h_RC := wglCreateContext(h_DC);
  if (h_RC = 0) then
  begin
    glKillWnd(Fullscreen);
    MessageBox(0, 'Unable to create an OpenGL rendering context', 'Error', MB_OK or MB_ICONERROR);
    Result := False;
    Exit;
  end;

  // Makes the specified OpenGL rendering context the calling thread's current rendering context
  if (not wglMakeCurrent(h_DC, h_RC)) then
  begin
    glKillWnd(Fullscreen);
    MessageBox(0, 'Unable to activate OpenGL rendering context', 'Error', MB_OK or MB_ICONERROR);
    Result := False;
    Exit;
  end;

  // Initializes the timer used to calculate the FPS
  SetTimer(h_Wnd, FPS_TIMER, FPS_INTERVAL, nil);

  // Settings to ensure that the window is the topmost window
  ShowWindow(h_Wnd, SW_SHOW);
  SetForegroundWindow(h_Wnd);
  SetFocus(h_Wnd);

  // Ensure the OpenGL window is resized properly
  glResizeWnd(Width, Height);
  glInit();

  Result := True;
end;


{--------------------------------------------------------------------}
{  Main message loop for the application                             }
{--------------------------------------------------------------------}
function WinMain(hInstance : HINST; hPrevInstance : HINST;
                 lpCmdLine : PChar; nCmdShow : Integer) : Integer; stdcall;
var
  msg : TMsg;
  finished : Boolean;
  DemoStart, LastTime : DWord;
begin
  finished := False;

  // Perform application initialization:
  if not glCreateWnd(400, 300, FALSE, 32) then
  begin
    Result := 0;
    Exit;
  end;

  DemoStart := GetTickCount();            // Get Time when demo started

  // Main message loop:
  while not finished do
  begin
    if (PeekMessage(msg, 0, 0, 0, PM_REMOVE)) then // Check if there is a message for this window
    begin
      if (msg.message = WM_QUIT) then     // If WM_QUIT message received then we are done
        finished := True
      else
      begin                               // Else translate and dispatch the message to this window
  	TranslateMessage(msg);
        DispatchMessage(msg);
      end;
    end
    else
    begin
      Inc(FPSCount);                      // Increment FPS Counter

      LastTime :=ElapsedTime;
      ElapsedTime :=GetTickCount() - DemoStart;     // Calculate Elapsed Time
      ElapsedTime :=(LastTime + ElapsedTime) DIV 2; // Average it out for smoother movement

      glDraw();                           // Draw the scene
      SwapBuffers(h_DC);                  // Display the scene

      if (keys[VK_ESCAPE]) then           // If user pressed ESC then set finised TRUE
        finished := True
      else
        ProcessKeys;                      // Check for any other key Pressed
    end;
  end;
  glKillWnd(FALSE);
  Result := msg.wParam;
end;


begin
  WinMain( hInstance, hPrevInst, CmdLine, CmdShow );
end.
