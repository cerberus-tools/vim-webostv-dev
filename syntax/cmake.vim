syntax keyword webosCMakeFunc webos_modules_init webos_component pkg_check_modules webos_add_compiler_flags webos_build_configured_file webos_build_system_bus_files  webos_machine_dep webos_add_linker_options  webos_include_install_paths _webos_set_bin_inst_dir webos_use_gtest
  \ webos_machine_impl_dep webos_distro_variant_dep webos_distro_dep webos_soc_family_dep webos_machine_variant_dep webos_core_os_dep webos_install_symlink webos_config_build_doxygen webos_build_nodejs_module webos_build_library webos_build_daemon webos_build_program webos_append_new_to_list webos_upstream_from_repo
  \ webos_test_provider webos_nyx_module_provider webos_configure_header_files webos_configure_source_files webos_build_db8_files webos_build_pkgconfig webos_build_configured_tree webos_make_source_path_absolute
  \ _webos_install_system_bus_files _webos_configure_tree _webos_check_install_dir _webos_add_target_define _webos_manipulate_flags _webos_add_doc_target _webos_make_path_absolute _webos_set_bin_permissions _webos_set_bin_inst_dir _webos_check_init_version _webos_do_common _webos_set_bin_inst_dir _webos_set_component_version _webos_messages_versions
syntax keyword webosCMakeNyx __nyx_get_pkgconfig_var _webos_nyx_support_init _webos_nyx_parse_modules webos_build_nyx_module
syntax keyword webosCMakeTask do_install do_compile
syntax keyword webosCMakeTest webos_add_test _webos_test_support_init

highlight link webosCMakeNyx PreProc
highlight link webosCMakeTest PreProc
highlight link webosCMakeFunc PreProc
highlight link webosCMakeTask Todo