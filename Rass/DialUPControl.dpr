program DialUPControl;
uses
  SvcMgr,
  sysutils,
  windows,
  types,
  winsvc,
  forms,
  uDCService in 'uDCService.pas' {DialUPControl_svc},
  uAboutForm in 'uAboutForm.pas' {FAbout},
  RASUnit in 'RASUnit.pas';

{$R *.RES}

function Installing: boolean;
begin
  Result:=FindCmdLineSwitch('install',['-','\','/'], true) or
    FindCmdLineSwitch('uninstall',['-','\','/'], true);
end;

function startservice: boolean;
var
  mgr, svc: integer;
  username, servicestartname: string;
  config: pointer;
  size: dword;
begin
  result:=false;
  mgr:=openscmanager(nil, nil, sc_manager_all_access);
  if mgr <> 0 then begin
    svc:=openservice(mgr, pchar('DialUPControl_svc'), service_all_access);
    result:=svc <> 0;
    if result then begin
      queryserviceconfig(svc, nil, 0, size);
      config:=allocmem(size);
      try
        queryserviceconfig(svc, config, size, size);
        servicestartname:=pqueryserviceconfig(config)^.lpservicestartname;
        if comparetext(servicestartname, 'localsystem') = 0 then
          servicestartname:='system';
      finally
        dispose(config);
      end;
      closeservicehandle(svc);
      end;
    closeservicehandle(mgr);
    end;
    if result then begin
      size:=256;
      setlength(username, size);
      getusername(pchar(username), size);
      setlength(username, strlen(pchar(username)));
      result:=comparetext(username, servicestartname) = 0;
      end;
    end;


begin
  if installing or startservice then begin
    SvcMgr.application.initialize;
    SvcMgr.Application.CreateForm(TDialUPControl_svc, DialUPControl_svc);
  SvcMgr.Application.CreateForm(TFAbout, FAbout);
    FAbout.fromservice:=true;
    SvcMgr.application.run;
    end else begin
      forms.application.showmainform:=false;
      forms.application.initialize;
      forms.application.createform(TDialUPControl_svc, DialUPControl_svc);
      forms.application.createform(tfabout, fabout);
      FAbout.fromservice:=false;
      forms.application.run;
      end;
end.

