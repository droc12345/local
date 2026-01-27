# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_11 python3_12 )

#python3_13 doesn't work yet due to broken dependencies on backend.

inherit systemd python-single-r1

DESCRIPTION="Open WebUI is an extensible, feature-rich, and user-friendly self-hosted AI platform designed to operate entirely offline. It supports various LLM runners like Ollama and OpenAI-compatible APIs, with built-in inference engine for RAG, making it a powerful AI deployment solution."
HOMEPAGE="https://openwebui.com/"
LICENSE="BSD-3.0"
SLOT="0"

IUSE="+systemd +ollama"
#IUSE="+systemd +nginx apache"

BEPEND="virtual/pkgconfig"

RDEPEND="\
    acct-user/genai\
    acct-group/genai\
"

DEPEND="\
    ${RDEPEND}\
    net-libs/nodejs[npm]\
    dev-python/virtualenv\
    dev-vcs/git\
    net-misc/curl\
    dev-lang/python\
    ollama? ( sci-ml/ollama )
"
#    nginx? ( www-servers/nginx[http2,nginx_modules_http_proxy,ssl] )\
#    apache? ( www-servers/apache[apache2_modules_proxy,apache2_modules_proxy_http2,apache2_modules_http2,ssl] )\

REQUIRED_USE="^^ ( python_single_target_python3_11 python_single_target_python3_12 )"

DISTUTILS_IN_SOURCE_BUILD=

INSTALL_DIR="/opt/open-webui"
CONFIG_DIR="/etc/open-webui"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/open-webui/open-webui.git"
	EGIT_BRANCH="main"
	SRC_URI=""
	KEYWORDS=""
    MY_PV=${PV//_}
    MY_PN="open-webui"
    MY_P="${MY_PN}-${MY_PV}"
    S="${WORKDIR}"
else
    MY_PV=${PV//_}
    MY_PN="open-webui"
    MY_P="${MY_PN}-${MY_PV}"
    SRC_URI="https://github.com/open-webui/open-webui/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
    S="${WORKDIR}"
fi


src_prepare() {
    default
}

src_install() {
    die() { eerror "$*" 1>&2 ; exit 1; }
    mkdir -p "${D}${INSTALL_DIR}"
    mkdir -p "${D}${CONFIG_DIR}"
    cp -R -f "${WORKDIR}/${MY_P}/." "${D}${INSTALL_DIR}/" || die "Install failed (base dir)!"
    einfo "Example configurations will be stored here: \"${CONFIG_DIR}\"."
#    cp -f "${WORKDIR}/${MY_P}/deploy/nginx.template" "${D}${CONFIG_DIR}/nginx.template.example"
#    cp -f "${WORKDIR}/${MY_P}/deploy/apache.conf" "${D}${CONFIG_DIR}/apache.conf.example"
    elog "Please pay attention to the fact that the example config file allows only local access to the Ollama (OLLAMA_BASE_URL is set to \"localhost\" in the file \"${CONFIG_DIR}/.env.example\")."
    chown -R genai:genai "${D}${INSTALL_DIR}"
    echo "${PV}-${RANDOM}" > "${D}${INSTALL_DIR}/package_version.txt"
    cp -f "${FILESDIR}/open-webui-server" open-webui-server || die
    dosbin open-webui-server
    chown -R genai:genai "${D}${INSTALL_DIR}"
    cd "${D}"
    if use systemd; then
        systemd_newunit "${FILESDIR}"/open-webui.service open-webui.service
    fi
    insinto "${CONFIG_DIR}"
    doins "${WORKDIR}/${MY_P}/.env.example"
}


pkg_postinst() {
    die() { eerror "$*" 1>&2 ; exit 1; }
    cd "${EROOT}${INSTALL_DIR}"
    if [ ! -f "${EROOT}${CONFIG_DIR}/.env" ]; then
        elog "Environment config file didn't exist a default one is used."
        elog "Please don't forget to adjust it according to your needs: \"${EROOT}${CONFIG_DIR}/.env\"."
        cp "${EROOT}${CONFIG_DIR}/.env.example" "${EROOT}${CONFIG_DIR}/.env"
    fi
    ln -sf "${EROOT}${CONFIG_DIR}/.env" "${EROOT}${INSTALL_DIR}/.env"
    #if ! command -v python3.12 >/dev/null 2>&1
    if use python_single_target_python3_11;then
        PYTHON_EXECUTABLE="python3.11"
    else
        PYTHON_EXECUTABLE="python3.12"
    fi
    npm install --force
    npm run build
    cd ./backend
    ${PYTHON_EXECUTABLE} -m venv ./venv || die "Cannot install virtual environment via selected executable \"${PYTHON_EXECUTABLE}\"!"
    #${PYTHON_EXECUTABLE} -m venv ./venv || die "Cannot install virtual environment via ${PYTHON_EXECUTABLE} executable!"
    source venv/bin/activate
    pip install --upgrade pip
    if [[ ${PV} != 9999 ]]; then
        sed -i "s,unstructured==0.16.17,unstructured>=0.16.17," "requirements.txt"
        sed -i "s,rapidocr-onnxruntime==1.4.4,rapidocr-onnxruntime>=1.4.4," "requirements.txt"
    fi
    pip install -r requirements.txt -U
    deactivate
    chown -R genai:genai "${EROOT}${INSTALL_DIR}"
    chmod 644 "${EROOT}${CONFIG_DIR}/.env"
    elog " [ Installation done ] "
    if use systemd; then
        elog "[Systemd] related:"
        elog "There is a systemd service installed."
        elog "After the installation script finishes it's work, please perform the following:"
        elog "sudo systemctl daemon-reload"
        elog "sudo systemctl enable --now open-webui"
    fi
#    if use nginx; then
#        elog "[Nginx] related:"
#        elog "After all of that, you probably want to enable the Nginx configuration."
#        elog "The easiest way is to perform it like that:"
#        elog "sudo ln -s ${EROOT}/etc/nginx/sites-available/open-webui.conf ${EROOT}/etc/nginx/open_webui_vhost.conf"
#        elog "Afterwards don't forget to restart nginx."
#        if use systemd; then
#            elog "systemctl restart nginx"
#        else
#            elog "rc-service nginx restart"
#        fi
#    fi
#    if use apache; then
#        elog "[Apache] related:"
#        elog "As you decided to use apache, the configutation for this server can be found in here: ${EROOT}/etc/apache2/sites-available/open_webui.conf"
#        elog "Just enable this virtualhost."
#        elog "Afterwards don't forget to restart apache."
#        if use systemd; then
#            elog "systemctl restart apache2"
#        else
#            elog "/etc/init.d/apache2 reload"
#        fi
#    fi
}

pkg_prerm() {
    if use systemd; then
        einfo "Stopping systemd services."
        systemctl daemon-reload
        systemctl stop open-webui
        systemctl disable open-webui
    fi
#    if use nginx; then
#        einfo "Removing Nginx templates."
#        [[ -e "${EROOT}/etc/nginx/open_webui_vhost.conf" ]] && rm -f "${EROOT}/etc/nginx/open_webui_vhost.conf"
#    fi
    einfo "Removing virtual environment and static files."
    [[ -d "${EROOT}${INSTALL_DIR}/venv" ]] && rm -rf "${EROOT}${INSTALL_DIR}/venv"
    [[ -f "${EROOT}${INSTALL_DIR}/package_version_init.txt" ]] && rm -f "${EROOT}${INSTALL_DIR}/package_version_init.txt"
#    [[ -d "${EROOT}${INSTALL_DIR}" ]] && rm -rf "${EROOT}${INSTALL_DIR}"
}

pkg_postrm() {
    if [[ -d "${EROOT}${INSTALL_DIR}" ]]; then
        ewarn ""
        ewarn "The directory \"${EROOT}${INSTALL_DIR}\" was not completely removed."
        ewarn "If that is not the expected behaviour, please remove it manually."
        ewarn ""
    fi
#    if [[ -d "${EROOT}${CONFIG_DIR}" ]]; then
#        ewarn ""
#        ewarn "The uninstall action did not remove the configuration files."
#        ewarn "They were left intact here: \"${EROOT}${CONFIG_DIR}\""
#        ewarn ""
#    fi
#    if use nginx; then
#        ewarn ""
#        ewarn "Please don't forget to reload nginx manually after this uninstallation."
#        ewarn ""
#    fi
}
