unit uDC;

interface
Uses winsvc;
  Procedure DC(const cod:byte);
implementation

Procedure DC(const cod:byte);
var
  h_manager,h_service:SC_Handle;
  service_status: TServiceStatus;
begin
  h_manager := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  if h_manager > 0 then Begin
    h_service:= OpenService(h_manager,'MyService',SERVICE_ALL_ACCESS);
    if h_service > 0 then Begin
      ControlService(h_service,cod,service_status);
      CloseServiceHandle(h_service);
      End;
    CloseServiceHandle(h_manager);
    End;
end;
end.
