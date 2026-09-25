
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Alertdialogs/warning.dart';
import 'package:crud_factories/Backend/Data/controlsMessagesError/errors.dart';
import 'package:crud_factories/Backend/Global/controllers/User.dart';
import 'package:crud_factories/Backend/Providers/SessionProvaider.dart';
import 'package:crud_factories/Backend/Providers/notificacionProvider.dart' show NotificationProvider;
import 'package:crud_factories/Objects/User.dart';
import 'package:crud_factories/Validators/user.dart' show UserValidator;
import 'package:crud_factories/Widgets/dropDownButton.dart' show GenericDropdown;
import 'package:crud_factories/Widgets/genericCheckbox.dart' show genericCheckbox;
import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:crud_factories/Widgets/materialButton.dart' show materialButton;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' hide showDialog;
import 'package:provider/provider.dart';

import '../Backend/Providers/UserProvider.dart';
import '../Widgets/textFieldPassword.dart';
import '../Widgets/textfield.dart';
import '../generated/l10n.dart';

class createUser extends StatefulWidget {
  const createUser({super.key});

  @override
  State<createUser> createState() => _createUserState();
}

class _createUserState extends State<createUser> {


  late final UserController controllers;

  bool showPassword1 = false;
  bool showPassword2 = false;
  bool userActive = true;
  bool changePassword = false;

  UserRole selectedRol = UserRole.admin;

  @override
  void initState() {
    super.initState();

    controllers = UserController(
        username: TextEditingController(),
        password: TextEditingController(),
        passwordVerify: TextEditingController(),
        mail: TextEditingController(),
        role: TextEditingController(),
        active: TextEditingController()
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = context
          .read<UserProvider>()
          .selected;

      if (!mounted || user == null) return;

      setState(() {
        loadSelectedUser(user);
      });
    });
  }

  @override
  void dispose() {
    controllers.username.dispose();
    controllers.password.dispose();
    controllers.passwordVerify!.dispose();
    controllers.mail!.dispose();
    controllers.role.dispose();
    controllers.active.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userSelected = context
        .watch<UserProvider>()
        .selected;
    final isEditing = userSelected != null;

    final title = isEditing
        ? S
        .of(context)
        .edit_user
        : S
        .of(context)
        .new_user;

    final action = isEditing
        ? S
        .of(context)
        .update
        : S
        .of(context)
        .create;

    final action2 = isEditing
        ? S
        .of(context)
        .undo
        : S
        .of(context)
        .reboot;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 400,
          maxHeight: 900,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // NO hace scroll
            headDialog(title: title),

            // Solo esto hace scroll
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    defaultTextfield(
                      nameCamp: S
                          .of(context)
                          .user,
                      controllerCamp: controllers.username,
                      context: context,
                    ),

                    defaultTextfield(
                      nameCamp: S
                          .of(context)
                          .mail,
                      controllerCamp: controllers.mail!,
                      context: context,
                    ),

                    if (isEditing)
                      genericCheckbox(
                        text: S
                            .of(context)
                            .change_password,
                        value: changePassword,
                        onChanged: (bool? value) {
                          setState(() {
                            changePassword = value ?? false;
                          });
                        },
                      ),

                    if (!isEditing || changePassword)
                      Column(
                        children: [
                          textfieldPassword(
                            nameCamp: S
                                .of(context)
                                .password,
                            controllerCamp: controllers.password,
                            campEdit: true,
                            obscureText: !showPassword1,
                          ),

                          genericCheckbox(
                            text: S
                                .of(context)
                                .show_password,
                            value: showPassword1,
                            onChanged: (bool? value) {
                              setState(() {
                                showPassword1 = value ?? false;
                              });
                            },
                          ),

                          textfieldPassword(
                            nameCamp: S
                                .of(context)
                                .verify_password,
                            controllerCamp: controllers.passwordVerify!,
                            obscureText: !showPassword2,
                          ),

                          genericCheckbox(
                            text: S
                                .of(context)
                                .show_password,
                            value: showPassword2,
                            onChanged: (bool? value) {
                              setState(() {
                                showPassword2 = value ?? false;
                              });
                            },
                          ),
                        ],
                      ),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: SizedBox(
                          width: 300,
                          child: GenericDropdown<UserRole>(
                            items: UserRole.values,
                            camp: S
                                .of(context)
                                .role,
                            selectedItem: selectedRol,
                            hint: S
                                .of(context)
                                .administrator,
                            itemLabel: (rol) {
                              switch (rol) {
                                case UserRole.admin:
                                  return S
                                      .of(context)
                                      .administrator;
                                case UserRole.user:
                                  return S
                                      .of(context)
                                      .user;
                              }
                            },
                            onChanged: (role) {
                              setState(() {
                                selectedRol = role!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),

                    genericCheckbox(
                      text: S
                          .of(context)
                          .active_user,
                      value: userActive,
                      onChanged: (bool? value) {
                        setState(() {
                          userActive = value ?? false;
                        });
                      },
                    ),

                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          materialButton(
                            nameAction: action,
                            function: () =>
                                _onSaveUser(
                                  context,
                                  userSelected,
                                  controllers,
                                  changePassword
                                ),
                          ),
                          const SizedBox(width: 20),
                          materialButton(
                            nameAction: action2,
                            function: () {
                              setState(() {
                                _onResetUser(
                                  userSelected,
                                  controllers,
                                );
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loadSelectedUser(User user) {
    controllers.username.text = user.username;
    controllers.password.clear();
    controllers.passwordVerify?.clear();
    controllers.mail?.text = user.mail ?? '';
    controllers.role.text = user.role;

    userActive = user.active;

    changePassword = false;
    showPassword1 = false;
    showPassword2 = false;

    selectedRol = user.role == 'admin'
        ? UserRole.admin
        : UserRole.user;
  }

  Future<void> _onSaveUser(BuildContext context,
      User? userSelected,
      UserController controllers, bool changePassword,) async {
    final isEditing = userSelected != null;
    final userProvider = context.read<UserProvider>();

    final sessionUser = context
        .read<SessionProvider>()
        .user;

    // Si estamos editando, necesitamos sesión.
    if (isEditing && sessionUser == null) {
      return;
    }

    // Saber si el usuario actual es admin.
    bool isAdmin = false;
    User? currentUser;


    if (sessionUser != null) {
      final currentUser = userProvider.users.cast<User?>().firstWhere(
            (u) => u?.id == sessionUser.id,
        orElse: () => null,
      );

      isAdmin = currentUser?.role == 'admin';
    }
      // Solo un admin puede crear/asignar un usuario admin.
      if (selectedRol == UserRole.admin && !isAdmin) {
        final notificationProvider = context.read<NotificationProvider>();

        String msg = S.of(context).requestAdminConfirm;

        final accepted = await warning(context, msg);

        if (accepted) {

          final result = await notificationProvider.requestAdminAccess(
            context: context,
            username: controllers.username.text,
            mail: controllers.mail?.text.trim() ?? '',
          );

          if (result.success)
          {
            await confirm(context, S.of(context).requestAdminSent);
          }
          return;
        }
        await error(context, S
            .of(context)
            .not_authorized);
        return;
      }




    // Validación
    final errorMsg = UserValidator.validate(
      context,
      controllers,
      userSelected,
      userProvider.users,
      changePassword,
    );

    if (errorMsg != null) {
      await error(context, errorMsg);
      return;
    }

    final user = User(
      id: isEditing ? userSelected!.id : "",
      username: controllers.username.text,
      mail: controllers.mail?.text.trim(),
      role: selectedRol == UserRole.admin
          ? 'admin'
          : 'user',
      active: userActive,
    );

    // CREAR
    if (!isEditing) {
      final result = await userProvider.create(
        user,
        controllers.password.text,
      );

      switch (result) {
        case CreateResult.success:
          userProvider.select(null);

          await confirm(
            context,
            S
                .of(context)
                .user_created_successfully,
          );
          break;

        case CreateResult.alreadyExists:
          await error(
            context,
            S
                .of(context)
                .user_already_exists,
          );
          break;

        case CreateResult.invalidData:
          await error(
            context,
            S
                .of(context)
                .invalid_data,
          );
          break;
      }

      return;
    }

    // EDITAR
    final newPass = changePassword
        ? controllers.password.text
        : "";

    final result = await userProvider.update(
      user,
      newPass,
    );

    switch (result) {
      case EditResult.success:
        await confirm(
          context,
          S
              .of(context)
              .user_updated_successfully,
        );
        break;

      case EditResult.alreadyExists:
        await error(
          context,
          S
              .of(context)
              .user_already_exists,
        );
        break;

      case EditResult.notFound:
        await error(
          context,
          S
              .of(context)
              .user_not_found,
        );
        break;

      case EditResult.invalidData:
        await error(
          context,
          S
              .of(context)
              .invalid_data,
        );
        break;

      case EditResult.error:
        await error(
          context,
          S
              .of(context)
              .error_updating_user,
        );
        break;
    }
  }

  void _onResetUser(User? userSelected, UserController controllers) {
    if (userSelected != null) {
      loadSelectedUser(userSelected);
    }
    else {
      controllers.username.clear();
      controllers.password.clear();
      controllers.passwordVerify!.clear();
      controllers.mail!.clear();
      controllers.role.clear();
      controllers.active.clear();

      selectedRol = UserRole.admin;
      showPassword1 = false;
      showPassword2 = false;
      userActive = true;
    }
  }

}
